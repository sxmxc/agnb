class_name CameraTriggerTargeter extends Node

@export var camera : Camera2D
@export var area_entered_event : CameraTriggerEvent

func _enter_tree():
	area_entered_event.on_event.connect(on_camera_entered)
	
func _exit_tree():
	area_entered_event.on_event.disconnect(on_camera_entered)

func on_camera_entered(area : CameraTrigger):
	camera.global_position = area.collision_shape_2d.global_position
