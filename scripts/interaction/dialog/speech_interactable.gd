extends Interactable
class_name SpeechInteractable

@export var dialogue : DialogueResource
@export var dialogue_title : String
@export var dialogue_balloon_scene : PackedScene

@onready var dialogue_anchor = %DialogueAnchor
@onready var dialogue_cam : PhantomCamera2D = $DialogueCam


# Called when the node enters the scene tree for the first time.
func _ready():
        super._ready()
        pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
        pass

func _on_interact(interactor : Interactor):
        var balloon : DialogueBalloon = dialogue_balloon_scene.instantiate()
        add_child(balloon)
        balloon.position = dialogue_anchor.position - balloon.pivot_offset
        interactor.get_parent().control_locked = true
        var world = GameManager.current_world
        if world and world.player_hud:
                world.player_hud.pause_level_timer()
        dialogue_cam.set_limit_target(get_parent().blocks.get_path())
        dialogue_cam.priority = 100
        balloon.start(dialogue, dialogue_title)
        on_interacted.emit(interactor)
        var callback = func():
                        interactor.get_parent().control_locked = false
                        balloon.queue_free()
                        dialogue_cam.priority = 0
                        if world and world.player_hud:
                                world.player_hud.resume_level_timer()
        balloon.dialogue_ended.connect(callback,4)
        super._on_interact(interactor)
