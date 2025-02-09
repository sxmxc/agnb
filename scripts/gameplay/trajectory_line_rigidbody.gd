extends Line2D

@export_flags_2d_physics var scan_layers


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func update_trajectory(dir: Vector2, speed: float, gravity: float, delta: float):
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
			var collider = ray.collider
			if collider is AnimatableBody2D:
				line_end = to_local(ray.position)
				break
			elif collider is TileMapLayer:
				var tilemap : TileMapLayer = collider as TileMapLayer
				var cell_pos = tilemap.local_to_map(ray.position - tilemap.get_parent().position)
				var tile = collider.get_cell_tile_data(cell_pos)
				if tile != null:
					var moving = tile.get_constant_linear_velocity(0)
					if moving:
						line_end = to_local(ray.position)
						break
					else:
						vel = vel.bounce(ray.normal) * 0.5
						line_end = to_local(ray.position)
			else:
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
	
