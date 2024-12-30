extends Control

@onready var velocity_value = %VelocityValue
@onready var rotation_value = %RotationValue
@onready var braking_value = %BrakingValue
@onready var upright_value = %UprightValue
@onready var grounded_value = %GroundedValue
@onready var jumping_value = %JumpingValue

var _player: Player
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !_player:
		return
	velocity_value.text = str(_player.velocity)
	rotation_value.text = str(_player.rotation) 
	braking_value.text = str(_player.braking_requested)
	upright_value.text = str(_player.reset_rotation_requested)
	grounded_value.text = str(_player.is_grounded)
	jumping_value.text = str(_player.is_jumping)
	pass

func register(player: Player):
	_player = player
