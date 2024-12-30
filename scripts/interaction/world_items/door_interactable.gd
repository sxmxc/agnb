extends Interactable
class_name DoorInteractable

@export var door : Door
@export var balloon_scene : PackedScene
@export var dialogue : DialogueResource
@export var dialogue_title: String

func _ready():
	super._ready()
	
func _on_area_entered(area : Area2D):
	if area is Interactor:
		area.interactable_in_range = !door.unlocked
		area.on_interact.connect(_on_interact.bind(area))
	
func _on_area_exited(area : Area2D):
	if area is Interactor:
		area.interactable_in_range = false
		area.on_interact.disconnect(_on_interact)

func _on_interact(interactor : Interactor):
	if interactor.action == "use":
		if GameManager.held_keys > 0:
			SoundManager.play_sound(DataManager.audio_dict["door_open"])
			GameManager.held_keys -= 1
			door.unlock()
			interactor.interactable_in_range = false
		else:
			var balloon : DialoguePanel = balloon_scene.instantiate()
			SoundManager.play_sound(DataManager.audio_dict["error"])
			add_child(balloon)
			balloon.start(dialogue, dialogue_title)
	super._on_interact(interactor)
