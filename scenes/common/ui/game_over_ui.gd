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
func _process(_delta):
	pass

func _on_game_over():
	is_game_over.value = true
	get_tree().paused = true
	SoundManager.play_music(DataManager.audio_dict["game_over_song"])
	visible = true
	pass


func _on_retry_button_pressed():
	GameManager.reset_player()
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_quit_button_pressed():
	SoundManager.play_ui_sound_random_pitch(DataManager.audio_dict["ui_select"])
	SceneTransitionManager.change_scene_with_transition(
		DataManager.config["main_menu_scene"],
		DataManager.config["transition_scene"]
	)
	get_tree().paused = false
	visible = false
	pass # Replace with function body.
