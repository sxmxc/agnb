extends Control

@export var master_slider : Slider
@export var music_slider : Slider
@export var sfx_slider : Slider
@export var enable_ui_sounds : CheckButton
@export var game_settings: GameSettings

@onready var master_bus = AudioServer.get_bus_index('Master')
@onready var music_bus = AudioServer.get_bus_index('Music')
@onready var sfx_bus = AudioServer.get_bus_index('SFX')
@onready var ui_bus = AudioServer.get_bus_index('UI')

var _settings_changed := false

func _enter_tree():
	master_slider.value_changed.connect(_on_master_audio_value_changed)
	music_slider.value_changed.connect(_on_music_audio_value_changed)
	sfx_slider.value_changed.connect(_on_sfx_audio_value_changed)
	enable_ui_sounds.toggled.connect(_on_enable_ui_value_changed)

func _exit_tree():
	master_slider.value_changed.disconnect(_on_master_audio_value_changed)
	music_slider.value_changed.disconnect(_on_music_audio_value_changed)
	sfx_slider.value_changed.disconnect(_on_sfx_audio_value_changed)
	enable_ui_sounds.toggled.disconnect(_on_enable_ui_value_changed)

func _ready():
	master_slider.value = game_settings.master_volume
	music_slider.value = game_settings.music_volume
	sfx_slider.value = game_settings.sfx_volume
	enable_ui_sounds.button_pressed = game_settings.ui_sound_enabled
	_settings_changed = false

func _process(_delta):
	%Apply.disabled = !_settings_changed
	%Save.disabled = !_settings_changed

func _on_master_audio_value_changed(value):
	SoundManager.set_master_volume(value)
	game_settings.master_volume = value
	_settings_changed = true


func _on_sfx_audio_value_changed(value):
	SoundManager.set_sound_volume(value)
	game_settings.sfx_volume = value
	_settings_changed = true


func _on_music_audio_value_changed(value):
	SoundManager.set_music_volume(value)
	game_settings.music_volume = value
	_settings_changed = true

func _on_enable_ui_value_changed(value):
	var vol = 0.0
	if value:
		vol = 1.0
	SoundManager.set_ui_volume(vol)
	game_settings.ui_sound_enabled = value
	_settings_changed = true
	pass


func _on_apply_pressed():
	SoundManager.play_ui_sound(DataManager.audio_dict["ui_select"])
	ResourceSaver.save(game_settings)
	_settings_changed = false
	pass # Replace with function body.


func _on_save_pressed():
	SoundManager.play_ui_sound(DataManager.audio_dict["ui_select"])
	ResourceSaver.save(game_settings)
	_settings_changed = false
	%Return.pressed.emit()
	pass # Replace with function body.
