extends RigidBody2D
class_name Player_RigidBody

@export var jump_force: float = 500.0
@export var tilt_torque: float = 5.0
@export var corrective_torque: float = 10.0
@export var rotation_smoothing: float = 0.1
@export var brake_intensity: float = 0.5  # Braking deceleration factor

@onready var trajectory_line: Line2D = %TrajectoryLine
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var ground_raycast: RayCast2D = %RayCast2D

var can_jump = false
var is_grounded = false
var time_since_grounded = 0.0
var reset_rotation_requested = false  # Flag to handle rotation reset
var braking_requested = false  # Flag to apply braking
var control_locked = false

func _ready():
	await get_parent().ready
	

func _physics_process(delta):
	if control_locked:
		return
		# Check grounding state
	is_grounded = _check_grounded()
	
	if is_grounded and !reset_rotation_requested:
		can_jump = true
		_update_trajectory(delta)
	else:
		can_jump = false
	
	# Jump
	if (can_jump) and Input.is_action_just_pressed("jump"):
		apply_jump()

	# Tilt
	if Input.is_action_pressed("move_left"):
		apply_torque_impulse(-tilt_torque)
		
	elif Input.is_action_pressed("move_right"):
		apply_torque_impulse(tilt_torque)

		
	# Request braking
	if Input.is_action_pressed("move_down"):
		braking_requested = true
	else:
		braking_requested = false

	# Request Rotation Reset
	if Input.is_action_pressed("move_up"):
		reset_rotation_requested = true
	else:
		reset_rotation_requested = false
	
	
	
func apply_jump():
	# Calculate the jump direction based on the current rotation
	var jump_direction = Vector2.UP.rotated(rotation)
	SoundManager.play_sound(DataManager.audio_dict["jump"])
	apply_impulse(jump_direction * jump_force)

func _integrate_forces(state):	
	# Handle rotation reset
	if reset_rotation_requested:
		var current_rotation = state.transform.get_rotation()
		var target_rotation = 0.0  # Always upright
		var rotation_difference = target_rotation - current_rotation

	# Normalize rotation difference to [-π, π]
		rotation_difference = fmod(rotation_difference + PI, TAU) - PI

	# Apply corrective torque with smoothing
		var torque_correction = rotation_difference * corrective_torque
		#var xform = state.transform
		#state.transform = xform.rotated(-xform.get_rotation())
		var reset_torque = torque_correction * 5 * state.step # Stronger correction for instant reset
		state.apply_torque(reset_torque)
		if current_rotation == target_rotation:
			reset_rotation_requested = false
	
	# Apply braking
	if braking_requested:
		var current_velocity = state.linear_velocity
		var braking_force = -current_velocity * brake_intensity
		state.angular_velocity = 0.0  # Stop spinning
		state.linear_velocity += braking_force * state.step  # Smooth deceleration over time
	

func die():
	EventBus.player_died.emit(self)

func _check_grounded() -> bool:
	for raycast in get_tree().get_nodes_in_group("ground_casts"):
		if raycast.is_colliding():
			return true
	return false

func _update_trajectory(delta):
	trajectory_line.global_position = global_position
	trajectory_line.update_trajectory(
		Vector2.UP.rotated(rotation),
		jump_force / mass,
		ProjectSettings.get_setting("physics/2d/default_gravity"),
		delta
	)
