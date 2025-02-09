extends Area2D
class_name Interactor

signal on_interact

@export var action : String = "use"

@onready var indicator = $Indicator

func _ready():
	await get_parent().ready
	global_position = get_parent().global_position
	indicator.hide()

func _physics_process(_delta):
	global_position = get_parent().global_position
	if get_parent().control_locked:
		return
	if Input.is_action_just_pressed(action):
		on_interact.emit()
