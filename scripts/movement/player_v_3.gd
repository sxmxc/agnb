class_name Player_v3 extends CharacterBody2D

# Exports
@export var jump_force: float = 500.0
@export var push_force: float = 200.0
@export var tilt_speed: float = 2.0
@export var brake_factor: float = 1.0
@export var rotation_correction_speed: float = 0.2
@export var bounciness: float = 0.5
#@export var friction: float = 0.5
@onready var drag : float = ProjectSettings.get_setting("physics/2d/default_linear_damp")
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
var on_wall: bool = false
var control_locked: bool = false
var on_moving_platform: bool = false
var platform_velocity: Vector2 = Vector2.ZERO
#var _is_on_floor: bool = false

func _ready():
	if name != "Player":
		name = "Player"
	#debug_ui.register(self)

func _physics_process(delta):
	if control_locked or is_dying:
		if trajectory_line.get_point_count() > 0:
			trajectory_line.clear_points()
		return
		
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
			
	if braking_requested:
		velocity = velocity.lerp(Vector2.ZERO, brake_factor * delta)
		
	_apply_rotation(delta)
	# Jump
	if is_grounded and Input.is_action_just_pressed("jump"):
		_apply_jump()
	# Brake
	braking_requested = Input.is_action_pressed("move_down")
	

	
	move_and_slide()
	_check_floor()
	
	var collision = get_last_slide_collision()
	if collision:
		if get_tree().get_nodes_in_group("Moveable").has(collision.get_collider()):
			collision.get_collider().apply_central_impulse(-collision.get_normal() * push_force)
		velocity = velocity.bounce(collision.get_normal()) * bounciness  
	if is_on_floor():
		_update_trajectory(delta)
		velocity.x = lerpf(velocity.x, 0, .1)
	
	
	platform_velocity = get_platform_velocity()
	on_wall = is_on_wall_only()

func _apply_rotation(delta):
	if Input.is_action_pressed("move_left"):
		if Input.is_action_pressed("fine_tune_left"):
			rotation -= (tilt_speed/4) * delta
		else:
			rotation -= tilt_speed * delta
		_update_trajectory(delta)
	elif Input.is_action_pressed("move_right"):
		if Input.is_action_pressed("fine_tune_right"):
			rotation += (tilt_speed/4) * delta
		else:
			rotation += tilt_speed * delta
		_update_trajectory(delta)
		# Reset orientation
	if !reset_rotation_requested:
		reset_rotation_requested = Input.is_action_just_pressed("move_up")
	if reset_rotation_requested:
		_reset_rotation()

func _apply_jump():
	SoundManager.play_sound_random_pitch(DataManager.audio_dict["jump"])
	# Calculate jump direction based on the current rotation
	var jump_direction = Vector2.UP.rotated(rotation)
	velocity = jump_direction.normalized() * jump_force
	is_jumping = true
	
func _reset_rotation():
	var tween = create_tween()
	tween.tween_property(self, "rotation", 0.0, rotation_correction_speed)
	tween.tween_callback(func(): reset_rotation_requested = false)
	trajectory_line.clear_points()

func _check_floor():
	if is_grounded and not is_on_floor():
		_on_leave_floor()
		
	if not is_grounded and is_on_floor():
		_on_touch_floor()
		
	is_grounded = is_on_floor()

func _on_touch_floor():
	if is_jumping:
		SoundManager.play_sound_random_pitch(DataManager.audio_dict["impact"])
		impact_particles.emitting = true
		pcam_noise.emit()
		is_jumping = false
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
