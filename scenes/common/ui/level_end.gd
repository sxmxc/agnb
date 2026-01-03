extends Control

@export var victory_song: AudioStream

@onready var coin_label = %CoinLabel
@onready var lives_label = %LivesLabel
@onready var time_bonus_label = %TimeBonusLabel
@onready var total_label = %TotalLabel
@onready var h_box_coins = %HBoxCoins
@onready var h_box_lives = %HBoxLives
@onready var h_box_time = %HBoxTime
@onready var h_box_total = %HBoxTotal
@onready var h_box_buttons = %HBoxButtons

var coin_total := 0
var lives_total := 0
var time_bonus := 0
var total := 0

# Called when the node enters the scene tree for the first time.
func _ready():
        hide()
        h_box_coins.hide()
        h_box_lives.hide()
        h_box_time.hide()
        h_box_total.hide()
        h_box_buttons.hide()
        process_mode = PROCESS_MODE_ALWAYS
        pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
        coin_label.text = str(coin_total)
        if coin_total == 0:
                coin_label.self_modulate = Color.RED
        else:
                coin_label.self_modulate = Color.WHITE
        lives_label.text = str(lives_total)
        if lives_total == 0:
                lives_label.self_modulate = Color.RED
        else:
                lives_label.self_modulate = Color.WHITE
        time_bonus_label.text = str(time_bonus)
        if time_bonus == 0:
                time_bonus_label.self_modulate = Color.RED
        else:
                time_bonus_label.self_modulate = Color.WHITE
        total_label.text = str(total)
        pass

func display_level_end():
        SoundManager.play_music(victory_song)
        show()
        tween_scores()

func tween_scores():
        time_bonus = calculate_time_score()
        var tween = get_tree().create_tween()
        h_box_coins.show()
        tween.tween_property(self,"coin_total", GameManager.num_coins, 1)
        tween.tween_callback(func(): h_box_lives.show())
        tween.tween_property(self,"lives_total", GameManager.num_lives, 1)
        tween.tween_callback(func(): h_box_time.show())
        tween.tween_property(self, "time_bonus", time_bonus, 1)
        tween.tween_callback(func(): h_box_total.show())
        var sum = GameManager.num_coins + GameManager.num_lives + time_bonus
        tween.tween_property(self,"total", sum , 1)
        tween.tween_callback(func(): h_box_buttons.show())
        pass

func calculate_time_score() -> int:
        var world = GameManager.current_world
        if not world or not world.player_hud:
                return 0
        var time_elapsed = world.player_hud.level_timer.time_elapsed
        # Maximum allowed time in seconds
        var max_time: float = 300.0  # 5 minutes
        # Calculate remaining time in seconds
        var remaining_time: float = max_time - time_elapsed
        # If time elapsed exceeds 5 minutes, return 0 points
        if remaining_time <= 0:
                return 0
        # Convert remaining time to points (1 point per min)
        return int(remaining_time / 60)


func _on_continue_button_pressed():
        var next_scene
        if DataManager.world_dict.has(GameManager.current_world_idx + 1):
                next_scene = load(DataManager.world_dict[GameManager.current_world_idx + 1].scene_path)
        else:
                next_scene = load(DataManager.world_dict[GameManager.current_world_idx])
        SceneTransitionManager.change_scene_with_transition(
                next_scene,
                DataManager.config["transition_scene"]
        )
        pass # Replace with function body.
