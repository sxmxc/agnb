class_name Player extends CharacterBody2D

# Exports
@export var jump_force: float = 500.0
@export var push_force: float = 100.0
@export var tilt_speed: float = 2.0
@export var brake_factor: float = 1.0
@export var rotation_correction_speed: float = 0.2
@export var bounciness: float = 0.5
@export var friction: float = 0.5

@onready var drag : float = ProjectSettings.get_setting("physics/2d/default_linear_damp")
@onready var ground_ray: RayCast2D = %RayCast2D
@onready var trajectory_line: Line2D = %TrajectoryLine
@onready var debug_ui = $Debug/DebugUI

# States
var braking_requested: bool = false
var reset_rotation_requested: bool = false
var is_grounded: bool = false
var is_jumping: bool = false
var control_locked: bool = false
#var _is_on_floor: bool = false

func _ready():
	if name != "Player":
		name = "Player"
	debug_ui.register(self)

func _physics_process(delta):
	if control_locked:
		return
	_check_floor()
	if is_grounded:
		_update_trajectory(delta)
	_apply_rotation(delta)
	# Jump
	if is_grounded and Input.is_action_just_pressed("jump"):
		_apply_jump()
	# Brake
	braking_requested = Input.is_action_pressed("move_down")
	
	_apply_physics(delta)

func _apply_rotation(delta):
	if Input.is_action_pressed("move_left"):
		rotation -= tilt_speed * delta
		_update_trajectory(delta)
	elif Input.is_action_pressed("move_right"):
		rotation += tilt_speed * delta
		_update_trajectory(delta)
		# Reset orientation
	if !reset_rotation_requested:
		reset_rotation_requested = Input.is_action_just_pressed("move_up")

func _check_grounded() -> bool:
	for raycast in get_tree().get_nodes_in_group("ground_casts"):
		if raycast.is_colliding():
			return true
	return false

func _apply_jump():
	# Calculate jump direction based on the current rotation
	var jump_direction = Vector2.UP.rotated(rotation)
	velocity = jump_direction * jump_force
	is_jumping = true
	SoundManager.play_sound(DataManager.audio_dict["jump"])

func _apply_physics(delta):
	
	if reset_rotation_requested:
		_reset_rotation()
	_apply_gravity(delta)
	
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
	pass
	
func _on_leave_floor():
	if velocity.y >= 0.0:
		pass

func _update_trajectory(delta):
	trajectory_line.global_position = global_position
	trajectory_line.update_trajectory(
		Vector2.UP.rotated(rotation),
		jump_force,
		ProjectSettings.get_setting("physics/2d/default_gravity"),
		delta
	)

func die():
	EventBus.player_died.emit(self)
