extends Label



# Called when the node enters the scene tree for the first time.
func _ready():
	var vp := VersionProvider.new()
	text = "v: %s\nb: %s" % [ProjectSettings.get_setting("application/config/version"), vp.get_git_commit_hash(5)]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
