extends Line2D
@onready var collision_test :CharacterBody2D= $CollisionTest


# Called when the node enters the scene tree for the first time.
func _ready():
	collision_test.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func update_trajectory(dir: Vector2, speed: float, gravity: float, delta: float):
	collision_test.set_process(true)
	var drag: float = ProjectSettings.get_setting("physics/2d/default_linear_damp")
	var max_points = 100
	clear_points()
	var pos: Vector2 = Vector2.ZERO
	var vel = dir * speed
	for i in max_points:
		add_point(pos)
		vel.y += gravity * delta - drag
		var collision = collision_test.move_and_collide(vel * delta, false, .08, true)
		if collision:
			vel = vel.bounce(collision.get_normal()) * 0.5
		pos += vel * delta
		collision_test.position = pos
	collision_test.set_process(false)
