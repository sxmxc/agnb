class_name PauseMenu extends Control

@export var is_paused : BoolReference
@export var is_game_over : BoolReference

func _enter_tree():
	is_paused.on_value_changed.connect(_on_pause_changed)
	
func _exit_tree():
	is_paused.on_value_changed.disconnect(_on_pause_changed)

func _ready():
	is_paused.value = false

func _input(event : InputEvent):
	if event.is_action_pressed("ui_cancel"):
		if is_game_over.value:
			return
		is_paused.value = !get_tree().paused

func _on_pause_changed(_old_value : bool, value : bool):
	if value:
		pause()
	else:
		resume()

func pause():
	SoundManager.play_music(DataManager.audio_dict["pause_song"])
	get_tree().paused = true
	visible = true
	
func resume():
	if GameManager.current_sidecar:
		SoundManager.play_music(GameManager.current_sidecar.world_theme_song)
	get_tree().paused = false
	visible = false
