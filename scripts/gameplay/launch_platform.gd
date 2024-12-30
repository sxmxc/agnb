extends RigidBody2D

@export var launch_force := 800
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.timeout.connect(_on_timer_timeout)
	timer.start(3)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	apply_impulse(Vector2(0,-launch_force))
	pass
