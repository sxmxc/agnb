extends Line2D

@onready var scan_layers = get_parent().collision_mask


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func update_trajectory(dir: Vector2, speed: float, gravity: float, delta: float):
	if is_queued_for_deletion():
		return
	var drag: float = ProjectSettings.get_setting("physics/2d/default_linear_damp")
	var max_points = 100
	clear_points()
	var line_start: Vector2 = Vector2.ZERO
	var line_end: Vector2
	var vel = dir * speed
		
	for i in max_points:
		add_point(line_start)
		vel.y += gravity * delta
		vel = vel * clampf(1.0 - drag * delta, 0, 1)
		line_end = line_start + (vel * delta)
		var ray := raycast_query2d(to_global(line_start) , to_global(line_end))
		if !ray.is_empty():
			vel = vel.bounce(ray.normal) * 0.5
			line_end = to_local(ray.position)
			
		line_start = line_end
		
func raycast_query2d(a: Vector2, b: Vector2) -> Dictionary:
	var space_state := get_world_2d().direct_space_state
	var query := PhysicsRayQueryParameters2D.create(a,b, scan_layers)
	var result := space_state.intersect_ray(query)
	if result:
		return result
	return {}

func shapecast_query2d(a: Vector2, b: Vector2, delta) -> Array[Dictionary]:
	var space_state := get_world_2d().direct_space_state
	var query := PhysicsShapeQueryParameters2D.new()
	query.shape = get_parent().collision_shape_2d
	query.collision_mask = scan_layers
	query.motion = a.move_toward(b, delta)
	var result = space_state.intersect_shape(query)
	if result:
		return result
	return [{}]
	
