class_name World
extends Node2D

@export var iid: String
@export var rect: Rect2i
@export var levels: Array[Level]

const RIGID_BODY_CHARACTER = preload("res://scenes/common/rigid_body_character.tscn")
const PLAYER= preload("res://scenes/common/player.tscn")

@export var world_name: String
@export var world_idx: int
@export var world_theme_song: AudioStream
@export var world_song_queue: AudioStreamPlaylist
@export var has_intro_played : bool = false


@export var balloon_scene : PackedScene
@export var dialogue : DialogueResource
@export var dialogue_title: String
@export var end_dialogue: DialogueResource
@export var end_dialogue_title: String
@export var is_paused : BoolReference
@export var has_completed_level: BoolReference
@export var goal_camera: GoalCam
@export var current_checkpoint: PlayerCheckpoint
@export var level_end_event: GameEvent


#@onready var player_start = %PlayerStart
@onready var player_hud = %player_hud
@onready var level_end_ui = %LevelEndUI

var _current_player: Player = null

func _init() -> void:
	child_order_changed.connect(_find_level_children)
	
func _ready():
	if world_song_queue:
		SoundManager.play_music_queue(world_song_queue)
	elif world_theme_song:
		SoundManager.play_music(world_theme_song)
	if !goal_camera:
		goal_camera = get_tree().get_first_node_in_group("GoalCam")
	if !current_checkpoint:
		current_checkpoint = get_tree().get_first_node_in_group("Checkpoint")
	GameManager.set_level(self)
	_current_player = spawn_player()
	player_hud.setup_ui()
	EventBus.player_died.connect(_on_player_death)
	EventBus.checkpoint_reached.connect(_on_checkpoint_reached)
	level_end_event.on_event.connect(play_level_end)
	if !has_intro_played:
		play_intro()
	pass # Replace with function body.

func _find_level_children() -> void:
	for child in get_children():
		if child is Level:
			if not levels.has(child):
				levels.append(child)
		else:
			for grandchild in child.get_children():
				if grandchild is Level:
					if not levels.has(grandchild):
						levels.append(grandchild)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func play_intro():
	_current_player.control_locked = true
	var balloon : DialoguePanel = balloon_scene.instantiate()
	get_parent().add_child(balloon)
	balloon.start(dialogue, dialogue_title)
	balloon.dialogue_ended.connect(func(): 
		player_hud.start_level_timer()
		_current_player.control_locked = false
		has_intro_played = true)

func play_level_end():
	player_hud.stop_level_timer()
	_current_player.control_locked = true
	var balloon : DialoguePanel = balloon_scene.instantiate()
	get_parent().add_child(balloon)
	balloon.start(end_dialogue, end_dialogue_title)
	balloon.dialogue_ended.connect(func():
		has_completed_level.value = true
		level_end_ui.display_level_end()
		)

func _on_player_death(_player: Player):
	player_hud.stop_level_timer()
	_current_player = null
	if GameManager.num_lives <= 0:
		EventBus.game_over.emit()
		return
	GameManager.num_lives -= 1
	_current_player = spawn_player()
	player_hud.resume_level_timer()
	pass

func _on_checkpoint_reached(which: PlayerCheckpoint):
	current_checkpoint = which

func spawn_player() -> Player:
	var new_player = PLAYER.instantiate()
	new_player.name = "Player"
	new_player.global_position = current_checkpoint.global_position
	get_parent().call_deferred("add_child", new_player)
	return new_player
