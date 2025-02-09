extends Control

@onready var key_amount = %KeyAmount
@onready var life_amount = %LifeAmount
@onready var coin_amount = %CoinAmount
@onready var level_label = %LevelLabel
@onready var level_timer : LevelTimer = %LevelTimer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func setup_ui():
	EventBus.player_lives_updated.connect(_on_lives_update)
	EventBus.player_keys_updated.connect(func(args): key_amount.text = "x%s" % args)
	EventBus.player_coins_updated.connect(func(args): coin_amount.text = "x%s" % args)
	if GameManager.current_world:
		level_label.text = GameManager.current_world.world_name
	key_amount.text = "x%s" % GameManager.held_keys
	life_amount.text = "%s" % GameManager.num_lives
	coin_amount.text = "%s" % GameManager.num_coins

func start_level_timer():
	level_timer.start()
	
func resume_level_timer():
	level_timer.resume()

func stop_level_timer():
	level_timer.stop()

func pause_level_timer():
	level_timer.pause()
	
func _on_lives_update(amount):
	life_amount.text = "%s" % amount
	if amount == 0:
		life_amount.self_modulate = Color.RED
	else:
		life_amount.self_modulate = Color.WHITE
