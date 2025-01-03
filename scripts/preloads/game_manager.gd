extends Node

@export var held_keys : int = 0 :
	get:
		return held_keys
	set(value):
		held_keys = value
		EventBus.player_keys_updated.emit(held_keys)
		
@export var num_lives : int = 3 :
	get:
		return num_lives
	set(value):
		num_lives = value
		EventBus.player_lives_updated.emit(num_lives)

@export var num_coins : int = 0 :
	get:
		return num_coins
	set(value):
		num_coins = value
		EventBus.player_coins_updated.emit(num_coins)

var current_sidecar: WorldSidecar = null

func reset_player():
	held_keys = 0
	num_coins = 0
	num_lives = 3

func pan_to_goal_cam():
	if !current_sidecar:
		return
	current_sidecar.goal_camera.phantom_camera_2d.set_priority(30)

func pan_to_active_cam():
	if !current_sidecar:
		return
	current_sidecar.goal_camera.phantom_camera_2d.set_priority(0)

func set_level(sidecar: WorldSidecar):
	current_sidecar = sidecar
	current_sidecar.tree_exited.connect(func(): 
		current_sidecar = null)
	
func pickup_item(type: DataManager.PickupType):
	match type:
		DataManager.PickupType.KEY:
			held_keys += 1
		DataManager.PickupType.COIN:
			if num_coins >= 99 :
				num_coins = 0
				num_lives += 1
				return
			num_coins += 1
		DataManager.PickupType.LIFE:
			num_lives += 1
