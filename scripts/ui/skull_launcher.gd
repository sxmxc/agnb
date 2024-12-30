extends Node2D

const FLYING_SKULL = preload("res://scenes/common/flying_skull.tscn")

@export_group("RNG Settings")
@export var max_speed := 100
@export var min_speed := 50
@export var max_angle := 45
@export var min_angle := 0
@export var max_time := 3
@export var min_time := 1
# Called when the node enters the scene tree for the first time.
func _ready():
	start_random_launch()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func launch(angle :float = 45, speed :=500, pos := Vector2.ZERO):
	var flying_skull = FLYING_SKULL.instantiate()
	var angle_rad = deg_to_rad(angle)
	flying_skull.position = to_local(pos)
	flying_skull.velocity = Vector2(speed * cos(angle_rad), -speed * sin(angle_rad))
	add_child(flying_skull)

func start_random_launch():
	var rnd_speed = randi_range(min_speed,max_speed)
	var rnd_angle = randi_range(min_angle, max_angle)
	var rnd_time = randi_range(min_time,max_time)
	var screen_size = get_viewport().get_visible_rect().size
	var rnd_pos = Vector2(randi_range(0, screen_size.x), randi_range(0, screen_size.y))
	launch(rnd_angle, rnd_speed, rnd_pos)
	get_tree().create_timer(rnd_time).timeout.connect(start_random_launch)
	
