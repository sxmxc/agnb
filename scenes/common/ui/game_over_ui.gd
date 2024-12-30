extends Control

@export var is_game_over : BoolReference

# Called when the node enters the scene tree for the first time.
func _ready():
	if visible:
		hide()
	process_mode = PROCESS_MODE_ALWAYS
	EventBus.game_over.connect(_on_game_over)
	is_game_over.value = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_game_over():
	is_game_over.value = true
	get_tree().paused = true
	SoundManager.play_music(DataManager.audio_dict["game_over_song"])
	visible = true
	pass
