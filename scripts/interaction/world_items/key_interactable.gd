extends Interactable
class_name PickupInteractable



@export var pickup_type : DataManager.PickupType
@export var coin_sprite : Texture2D
@export var key_sprite : Texture2D
@export var life_sprite : Texture2D
@export var has_been_collected: bool = false

@onready var sprite_2d = $Sprite2D

var pickup_target: Interactor = null


func _ready():
	match pickup_type:
		DataManager.PickupType.COIN:
			sprite_2d.texture = coin_sprite
		DataManager.PickupType.KEY:
			#if has_been_collected:
				#queue_free()
				#return
			sprite_2d.texture = key_sprite
		DataManager.PickupType.LIFE:
			sprite_2d.texture = life_sprite
	tween_loop()
	super._ready()

func _process(delta):
	if pickup_target:
		var dir : Vector2 = sprite_2d.global_position.direction_to(pickup_target.global_position)
		sprite_2d.global_position += dir * 1000 * delta
		if sprite_2d.global_position.distance_to(pickup_target.global_position) <= 5:
			_on_picked_up()

func _on_area_entered(area : Area2D):
	if area is Interactor:
		pickup_target = area
	
func _on_area_exited(_area : Area2D):
	return

func _on_picked_up():
	SoundManager.play_sound(DataManager.audio_dict["pickup"])
	GameManager.pickup_item(pickup_type)
	queue_free()
	pass

func tween_loop():
	if pickup_target:
		return
	var tween = create_tween()
	tween.tween_property(sprite_2d, "position", sprite_2d.position + Vector2(0, -2), .25)
	tween.parallel().tween_property(sprite_2d, "scale", Vector2(1.25,1.25), .25)
	tween.tween_property(sprite_2d, "position", Vector2.ZERO, .25)
	tween.parallel().tween_property(sprite_2d, "scale", Vector2.ONE, .25)
	tween.tween_callback(tween_loop)
