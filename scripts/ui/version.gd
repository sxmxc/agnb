extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	text = "v%s" % ProjectSettings.get_setting("application/config/version")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
