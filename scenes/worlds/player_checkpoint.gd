extends Marker2D
class_name PlayerCheckpoint

@export var player_reached: bool = false

@onready var area_2d = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	area_2d.area_entered.connect(_on_area_2d_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_area_2d_entered(area):
	if area is Interactor:
		if !player_reached:
			player_reached = true
			EventBus.checkpoint_reached.emit(self)
