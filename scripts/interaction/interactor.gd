extends Area2D
class_name Interactor

signal on_interact

@export var action : String = "use"

@onready var indicator = $Indicator

func _ready():
	indicator.hide()

func _physics_process(_delta):
	if get_parent().control_locked:
		return
	global_position = get_parent().global_position
	if Input.is_action_just_pressed(action):
		on_interact.emit()
