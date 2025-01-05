extends Area2D
class_name CameraTrigger

@onready var collision_shape_2d : CollisionShape2D
@onready var area_pcam : PhantomCamera2D = $PhantomCamera2D

@export var level: Level
@export var area_enter: CameraTriggerEvent
@export var area_exit: CameraTriggerEvent

func _ready() -> void:
	if collision_shape_2d != null:
		collision_shape_2d.queue_free()
	body_entered.connect(_entered_area)
	body_exited.connect(_exited_area)

func setup_trigger(tile_map: TileMapLayer):
	collision_shape_2d = CollisionShape2D.new()
	var tile_size = tile_map.tile_set.tile_size
	var shape = RectangleShape2D.new()
	shape.size = tile_map.get_used_rect().size * tile_size
	collision_shape_2d.shape = shape
	collision_shape_2d.position = Vector2((shape.size.x + tile_size.x) / 2, (shape.size.y - tile_size.y) / 2) 
	add_child(collision_shape_2d)
	area_pcam.set_limit_target(collision_shape_2d.get_path())
	area_pcam.set_follow_target(null)
	#area_pcam.set_follow_target(get_tree().get_nodes_in_group("Player")[0])

func _entered_area(body) -> void:
	if body is Player:
		area_enter.trigger(self)
		area_pcam.follow_mode = PhantomCamera2D.FollowMode.SIMPLE
		area_pcam.set_follow_target(body)
		area_pcam.set_priority(20)
		
		

func _exited_area(body) -> void:
	if body is Player:
		area_exit.trigger(self)
		area_pcam.set_priority(0)
		area_pcam.set_follow_target(null)
		
		
