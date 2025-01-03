class_name World
extends Node2D

@export var iid: String
@export var rect: Rect2i
@export var levels: Array[Level]

func _init() -> void:
	child_order_changed.connect(_find_level_children)

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
