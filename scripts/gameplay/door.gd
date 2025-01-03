extends StaticBody2D
class_name Door

@export var unlocked: bool = false :
	get():
		return unlocked
	set(value):
		unlocked = value
		if unlocked:
			sprite_closed.hide()
			sprite_open.show()
		else:
			sprite_closed.show()
			sprite_open.hide()

@onready var sprite_closed = $SpriteClosed
@onready var sprite_open = $SpriteOpen


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func unlock():
	unlocked = true
	#sprite_closed.hide()
	#sprite_open.show()
	process_mode = PROCESS_MODE_DISABLED
	
