extends Area2D
class_name ButtonArea

@export var entered_event : GameEvent
@export var exited_event: GameEvent

# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body is Player:
		entered_event.trigger()
	pass # Replace with function body.


func _on_body_exited(body):
	if body is Player:
		exited_event.trigger()
	pass # Replace with function body.
