extends Area2D

class_name Interactor

@export var action : String = "use"

@onready var indicator = $Indicator

var interactable_in_range: bool = false

signal on_interact

func _ready():
	indicator.hide()

func _process(_delta):
	global_position = get_parent().global_position
	indicator.visible = interactable_in_range
	if Input.is_action_just_pressed(action):
		on_interact.emit()
