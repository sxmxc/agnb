extends Interactable
class_name DialogueInteractable

@export var balloon_scene : PackedScene
@export var dialogue : DialogueResource
@export var dialogue_title: String

func _on_area_exited(area : Area2D):
	super._on_area_exited(area)


func _on_interact(interactor : Interactor):
	DialogueManager.show_dialogue_balloon_scene(balloon_scene, dialogue, dialogue_title)
	super._on_interact(interactor)
