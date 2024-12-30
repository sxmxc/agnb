extends RigidBody2D

@export var piston_force: float = 5000.0
@export var reverse_delay: float = 500  # Delay in milliseconds
@export var groove_length: float = 100.0

var direction: int = 1
var last_reverse_time: int = 0

func _physics_process(delta):
	var joint = get_parent()
	
	# Get the normalized axis of the joint
	var axis = joint.global_transform.x.normalized()

	# Calculate the relative position of the rigid body from the joint's origin
	var relative_position = global_position - joint.global_transform.origin

	# Calculate the position along the axis using dot product
	var position_along_axis = relative_position.dot(axis)

	# Debugging: Print the position along the axis
	#print("Position along axis: ", relative_position)

	# Apply force along the joint's axis
	apply_central_impulse(axis * direction * piston_force)

	# Reverse direction when the piston reaches the groove's limits
	var groove_extent = groove_length / 2
	if abs(relative_position.x) >= groove_extent:
		var current_time = Time.get_ticks_msec()
		if (current_time - last_reverse_time) >= reverse_delay:
			direction *= -1
			last_reverse_time = current_time
