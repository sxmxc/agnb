class_name Player extends CharacterBody2D

# Exports
@export var jump_force: float = 500.0
@export var push_force: float = 100.0
@export var tilt_speed: float = 2.0
@export var brake_factor: float = 1.0
@export var rotation_correction_speed: float = 0.2
@export var bounciness: float = 0.5
@export var on_moving_platform: bool = false
@export var platform_velocity: Vector2 = Vector2.ZERO
#@export var friction: float = 0.5
@onready var drag : float = ProjectSettings.get_setting("physics/2d/default_linear_damp")
@onready var ground_ray: RayCast2D = %RayCast2D
@onready var trajectory_line: Line2D = %TrajectoryLine
@onready var debug_ui = $Debug/DebugUI
@onready var collision_shape_2d = $CollisionShape2D
@onready var pcam_noise = $PhantomCameraNoiseEmitter2D
@onready var death_particles : GPUParticles2D = $DeathParticles
@onready var sprite = $Sprite
@onready var impact_particles = $ImpactParticles

# States
var braking_requested: bool = false
var reset_rotation_requested: bool = false
var is_grounded: bool = false
var is_jumping: bool = false
var is_dying: bool = false
var control_locked: bool = false

func _ready():
	if name != "Player":
		name = "Player"
	debug_ui.register(self)

func _physics_process(delta):
	if control_locked or is_dying:
		if trajectory_line.get_point_count() > 0:
			trajectory_line.clear_points()
		return
	
	_apply_rotation(delta)
	_check_floor()
	
	if is_grounded:
		_update_trajectory(delta)
	# Jump
	if is_grounded and Input.is_action_just_pressed("jump"):
		_apply_jump()
	# Brake
	braking_requested = Input.is_action_pressed("move_down")
	
	if on_moving_platform:
		_apply_gravity(delta)
		velocity.x = lerpf(velocity.x, 0, 5 * delta)
		move_and_slide()
		apply_floor_snap()
	else:
		_apply_physics(delta)
	

func _apply_rotation(delta):
	if Input.is_action_pressed("move_left"):
		if Input.is_action_pressed("fine_tune_left"):
			rotation -= (tilt_speed/4) * delta
		else:
			rotation -= tilt_speed * delta
		
	elif Input.is_action_pressed("move_right"):
		if Input.is_action_pressed("fine_tune_right"):
			rotation += (tilt_speed/4) * delta
		else:
			rotation += tilt_speed * delta

	if !reset_rotation_requested:
		reset_rotation_requested = Input.is_action_just_pressed("move_up")
	if reset_rotation_requested:
		_reset_rotation()

func _check_grounded() -> bool: 
	on_moving_platform = false
	platform_velocity = Vector2.ZERO
	for ray in get_tree().get_nodes_in_group("ground_casts"):
		var raycast = ray as RayCast2D
		if raycast.is_colliding():
			var collider = raycast.get_collider()
			if collider is AnimatableBody2D:
				on_moving_platform = true
				platform_velocity = get_platform_velocity()
			elif collider is TileMapLayer:
				var tilemap : TileMapLayer = collider as TileMapLayer
				var cell_pos = tilemap.local_to_map(raycast.get_collision_point() - tilemap.get_parent().position)
				var tile = collider.get_cell_tile_data(cell_pos)
				if tile != null:
					var vel = tile.get_constant_linear_velocity(0)
					if vel:
						on_moving_platform = true
			return true
	return false

func _apply_jump():
	SoundManager.play_sound_random_pitch(DataManager.audio_dict["jump"])
	# Calculate jump direction based on the current rotation
	var jump_direction = Vector2.UP.rotated(rotation)
	velocity = jump_direction * jump_force
	is_jumping = true
	

func _apply_physics(delta):
	_apply_gravity(delta)
	
	#if is_grounded:
		#if on_moving_platform:
			## Adjust player velocity based on the platform
			#apply_floor_snap()

	if braking_requested:
		velocity = velocity.lerp(Vector2.ZERO, brake_factor * delta)

	var collision = move_and_collide(velocity * delta, false, .08, true)
	if collision:
		if get_tree().get_nodes_in_group("Moveable").has(collision.get_collider()):
			collision.get_collider().apply_central_impulse(-collision.get_normal() * push_force)
		velocity = velocity.bounce(collision.get_normal()) * bounciness

func _apply_gravity(delta):
	velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta - drag

func _reset_rotation():
	var tween = create_tween()
	tween.tween_property(self, "rotation", 0.0, rotation_correction_speed)
	tween.tween_callback(func(): reset_rotation_requested = false)

func _check_floor():
	if is_grounded and not _check_grounded():
		_on_leave_floor()
		
	if not is_grounded and _check_grounded():
		_on_touch_floor()
		
	is_grounded = _check_grounded()

func _on_touch_floor():
	is_jumping = false
	SoundManager.play_sound_random_pitch(DataManager.audio_dict["impact"])
	impact_particles.emitting = true
	pcam_noise.emit()
	pass
	
func _on_leave_floor():
	if velocity.y >= 0.0:
		pass

func _update_trajectory(delta):
	trajectory_line.global_position = global_position
	if rotation == 0.0:
			trajectory_line.clear_points()
			return
	trajectory_line.update_trajectory(
		Vector2.UP.rotated(rotation),
		jump_force,
		ProjectSettings.get_setting("physics/2d/default_gravity"),
		delta
	)

func die():
	is_dying = true
	sprite.hide()
	death_particles.emitting = true
	await get_tree().create_timer(2).timeout
	EventBus.player_died.emit(self)
	call_deferred("queue_free")
