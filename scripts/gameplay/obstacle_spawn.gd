extends Marker2D

@export var obstacle : PackedScene
@export var spawn_interval: float = 5.0
@export var spawn_amount: int = 1
@export var spawn_parent: NodePath
# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().create_timer(spawn_interval, false, true).timeout.connect(spawn_loop)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_loop():
	for x in spawn_amount:
		var new_obs = obstacle.instantiate()
		new_obs.position = get_node(spawn_parent).to_local(position)
		get_node(spawn_parent).add_child(new_obs)
	get_tree().create_timer(spawn_interval, false, true).timeout.connect(spawn_loop)
	pass
