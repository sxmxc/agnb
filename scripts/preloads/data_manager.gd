extends Node

enum PickupType {KEY,COIN,LIFE}

var config = {
	"transition_scene": preload("res://scenes/scene_transitions/circle_transition.tscn"),
	"main_menu_scene": preload("res://scenes/menus/main_menu.tscn")
}

var world_dict = {
	1: preload("res://game_resources/world_refs/world_1.tres"),
	2: preload("res://game_resources/world_refs/world_2.tres")
}

var audio_dict = {
	"main_theme_song" :  preload("res://assets/audio/music/Bone Yard Waltz - Loopable.ogg"),
	"game_over_song": preload("res://assets/audio/music/Dungeon Theme.mp3"),
	"pause_song": preload("res://assets/audio/music/8bit Bossa.mp3"),
	"jump": preload("res://assets/audio/fx/jump_1.wav"),
	"ui_select": preload("res://assets/audio/fx/ui_select.wav"),
	"door_open": preload("res://assets/audio/fx/pickup_1.wav"),
	"pickup": preload("res://assets/audio/fx/pickup_2.wav"),
	"error": preload("res://assets/audio/fx/error.wav"),
	"impact": preload("res://assets/audio/fx/hit_1.wav")
}

var portrait_dict = {
	"roger": preload("res://assets/aseprite/skull_icon.png")
}

var menu_comments := [
	"No body, no problem. Still got me charm, eh?",
	"I've had better days!",
	"What’re you waitin’ for? Me to grow legs?",
	"Don’t mind me, just flyin’ by.",
	"Oh, so you’re just gonna stare at the menu?",
	"Start the game already!",
	"Me body’s not gonna find itself!",
	"Oi, watch me fly!",
	"Oi, press a button already!",
	"I’m all jaw, baby!",
	"Oi, where’s me body?",
	"Bet you wish you could do this!",
	"Zoomin’ like a legend!",
	"I ain't got no body...",
	"Yakka tak ta a yakka tak ta ha!"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
