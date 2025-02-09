extends TileMapLayer
class_name ActiveConveyorTileLayer

@export var collidable_terrain_set : int = 0
@export var non_collidable_terrain_set : int = 1
@export var conveyor_active: bool = false :
	get:
		return conveyor_active
	set(value):
		conveyor_active = value
		if value:
			activate()
		else:
			deactivate()

@export var activated_event : GameEvent
@export var deactivated_event: GameEvent
@export var toggled_event: GameEvent
# Called when the node enters the scene tree for the first time.
func _ready():
	activated_event.on_event.connect(func(): conveyor_active = true)
	deactivated_event.on_event.connect(func(): conveyor_active = false)
	toggled_event.on_event.connect(func(): conveyor_active = !conveyor_active)
	#for cell in get_used_cells():
		#get_cell_tile_data(cell).set_constant_linear_velocity(0, Vector2(-20,-20))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func activate():
	for cell in get_used_cells():
		set_cells_terrain_connect([cell],collidable_terrain_set,get_cell_tile_data(cell).terrain)

func deactivate():
	for cell in get_used_cells():
		set_cells_terrain_connect([cell],non_collidable_terrain_set,get_cell_tile_data(cell).terrain)
