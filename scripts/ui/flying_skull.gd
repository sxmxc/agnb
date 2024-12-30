extends Sprite2D
class_name FlyingSkull

const SKULL_ICON = preload("res://assets/aseprite/skull_icon.png")

@onready var visible_on_screen_notifier_2d = $VisibleOnScreenNotifier2D
@onready var comment : String = "Cheaky comment!"
@onready var comment_ballon = $CommentBallon
@onready var _comment_label = %CommentLabel

var drag = ProjectSettings.get_setting("physics/2d/default_linear_damp")
var gravity = Vector2(0,150)
var velocity: Vector2

func setup(com):
	comment = com

# Called when the node enters the scene tree for the first time.
func _ready():
	var rnd_comment = DataManager.menu_comments[randi_range(0, DataManager.menu_comments.size() - 1)]
	comment_ballon.hide()
	_comment_label.text = rnd_comment
	visible_on_screen_notifier_2d.screen_exited.connect(_on_visible_on_screen_notifier_2d_screen_exited)
	texture = SKULL_ICON
	get_tree().create_timer(.2).timeout.connect(func(): comment_ballon.show())
	pass # Replace with function body.

func _physics_process(delta):
	if !visible_on_screen_notifier_2d.is_on_screen():
		queue_free()
	_apply_physics(delta)
	
func _apply_physics(delta):
	_apply_gravity(delta)
	position += velocity * delta

func _apply_gravity(delta):
	velocity.y += gravity.y * delta - drag
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	pass # Replace with function body.
