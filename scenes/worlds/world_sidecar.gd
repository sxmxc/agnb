extends Node
class_name WorldSidecar

const RIGID_BODY_CHARACTER = preload("res://scenes/common/rigid_body_character.tscn")
const PLAYER_V_2 = preload("res://scenes/common/player_v2.tscn")

@export var world_name: String
@export var world_theme_song: AudioStream
@export var has_intro_played : bool = false
@export var balloon_scene : PackedScene
@export var dialogue : DialogueResource
@export var dialogue_title: String
@export var is_paused : BoolReference
@export var goal_camera: PhantomCamera2D
@export var current_checkpoint: PlayerCheckpoint


#@onready var player_start = %PlayerStart
@onready var player_hud = %player_hud

var _current_player: Player = null


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_parent().ready
	if world_theme_song:
		SoundManager.play_music(world_theme_song)
	GameManager.set_level(self)
	if !current_checkpoint:
		current_checkpoint = get_tree().get_first_node_in_group("Checkpoint")
	_current_player = spawn_player()
	player_hud.setup_ui()
	EventBus.player_died.connect(_on_player_death)
	EventBus.checkpoint_reached.connect(_on_checkpoint_reached)
	if !has_intro_played:
		play_intro()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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

func _on_player_death(player: Player):
	_current_player = null
	player.queue_free()
	if GameManager.num_lives <= 0:
		player_hud.stop_level_timer()
		EventBus.game_over.emit()
		return
	GameManager.num_lives -= 1
	_current_player = spawn_player()
	pass

func _on_checkpoint_reached(which: PlayerCheckpoint):
	current_checkpoint = which

func spawn_player() -> Player:
	var new_player = PLAYER_V_2.instantiate()
	new_player.name = "Player"
	new_player.global_position = current_checkpoint.global_position
	get_parent().add_child(new_player)
	return new_player
