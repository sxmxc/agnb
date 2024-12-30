extends Node

@export var balloon_scene : PackedScene
@export var dialogue : DialogueResource
@export var dialogue_title: String
@export var is_paused : BoolReference
const RIGID_BODY_CHARACTER = preload("res://scenes/common/rigid_body_character.tscn")
@onready var camera_targeter = $camera_player/CameraTargeter
@onready var player_start = %PlayerStart

@onready var player_hud = %player_hud

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_player()
	EventBus.player_died.connect(_on_player_death)
	var balloon : DialoguePanel = balloon_scene.instantiate()
	$ui.add_child(balloon)
	balloon.start(dialogue, dialogue_title)
	balloon.dialogue_ended.connect(func(): player_hud.start_level_timer())
	EventBus.player_lives_updated.emit(GameManager.num_lives)
	EventBus.player_keys_updated.emit(GameManager.held_keys)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_player_death(player: Player):
	camera_targeter.remove_target(player.get_path())
	player.queue_free()
	if GameManager.num_lives <= 0:
		EventBus.game_over.emit
		return
	GameManager.num_lives -= 1
	spawn_player()
	EventBus.player_lives_updated.emit(GameManager.num_lives)
	pass

func spawn_player():
	var new_player = RIGID_BODY_CHARACTER.instantiate()
	new_player.global_position = player_start.global_position
	add_child(new_player)
	camera_targeter.add_target(new_player.get_path())
