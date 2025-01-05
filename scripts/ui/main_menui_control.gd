extends Control

enum Menu { PRESS_KEY, MAIN_MENU, SETTINGS_MENU }

@export var start_button : Button
@export var settings_button : Button
@export var exit_button : Button

@export var start_scene : PackedScene
@export var transition_path : PackedScene


@onready var press_key = %PressKey

var current_menu : Menu = Menu.PRESS_KEY

func _ready():
	start_scene = load(DataManager.world_dict[1].scene_path)
	tween_press_key()

func _enter_tree():
	start_button.pressed.connect(_on_start_button_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	exit_button.pressed.connect(_on_exit_pressed)
	
func _exit_tree():
	start_button.pressed.disconnect(_on_start_button_pressed)
	settings_button.pressed.disconnect(_on_settings_pressed)
	exit_button.pressed.disconnect(_on_exit_pressed)
	
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE and current_menu == Menu.MAIN_MENU:
			SoundManager.play_ui_sound_random_pitch(DataManager.audio_dict["ui_select"])
			current_menu = Menu.PRESS_KEY
			return
		if current_menu == Menu.PRESS_KEY:
			SoundManager.play_ui_sound_random_pitch(DataManager.audio_dict["ui_select"])
			current_menu = Menu.MAIN_MENU
			return

func _on_start_button_pressed():
	SoundManager.play_ui_sound_random_pitch(DataManager.audio_dict["ui_select"])
	SceneTransitionManager.change_scene_with_transition(
		start_scene,
		transition_path
	)

func _on_exit_pressed():
	SoundManager.play_ui_sound_random_pitch(DataManager.audio_dict["ui_select"])
	get_tree().quit()


func _on_settings_pressed():
	SoundManager.play_ui_sound_random_pitch(DataManager.audio_dict["ui_select"])
	current_menu = Menu.SETTINGS_MENU


func _on_return_main_menu_button_pressed():
	SoundManager.play_ui_sound_random_pitch(DataManager.audio_dict["ui_select"])
	current_menu = Menu.MAIN_MENU

func tween_press_key():
	if !current_menu == Menu.PRESS_KEY:
		return
	var tween = create_tween()
	tween.tween_property(press_key, "self_modulate", Color.TRANSPARENT, .2)
	tween.tween_property(press_key, "self_modulate", Color.WHITE,.2)
	tween.tween_callback(tween_press_key)
