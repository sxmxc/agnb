extends Area2D
class_name CameraTrigger

@onready var collision_shape_2d : CollisionShape2D = $CollisionShape2D
@onready var area_pcam : PhantomCamera2D = $PhantomCamera2D

@export var area_enter: CameraTriggerEvent
@export var area_exit: CameraTriggerEvent

func _ready() -> void:
	body_entered.connect(_entered_area)
	body_exited.connect(_exited_area)
	await get_parent().ready
	var shape = RectangleShape2D.new()
	shape.size = get_parent().size
	collision_shape_2d.shape = shape
	collision_shape_2d.position = Vector2(shape.size.x  / 2, shape.size.y / 2)
	area_pcam.set_limit_target(collision_shape_2d.get_path())
	area_pcam.set_follow_target(null)
	#area_pcam.set_follow_target(get_tree().get_nodes_in_group("player")[0])

func _entered_area(body) -> void:
	if body is Player:
		area_enter.trigger(self)
		area_pcam.set_priority(20)
		area_pcam.set_follow_target(body)
		
		

func _exited_area(body) -> void:
	if body is Player:
		area_exit.trigger(self)
		area_pcam.set_priority(0)
		area_pcam.set_follow_target(null)
		
		
