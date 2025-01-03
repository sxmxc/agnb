extends Interactable
class_name EventInteractable

@export var event : GameEvent

func _on_area_exited(area : Area2D):
	super._on_area_exited(area)


func _on_interact(interactor : Interactor):
	event.trigger()
	super._on_interact(interactor)
