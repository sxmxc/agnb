class_name Level
extends Node2D

@export var iid: String
@export var world_position: Vector2
@export var size: Vector2i
@export var fields: Dictionary
@export var neighbours: Array[Level]
@export var bg_color: Color

@onready var blocks : TileMapLayer= $Blocks
@onready var camera_trigger : CameraTrigger

func _ready() -> void:
	size = blocks.get_used_rect().size * 16
	for child in get_children():
		if child is CameraTrigger:
			camera_trigger = child
			camera_trigger.setup_trigger(blocks)
	queue_redraw()

func _draw() -> void:
	if Engine.is_editor_hint():
		draw_rect(Rect2(Vector2.ZERO, size), bg_color, false, 2.0)
