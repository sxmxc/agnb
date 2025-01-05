extends Label
class_name LevelTimer

var time_elapsed := 0.0
var time_string: String = "00:00:00"

var is_stopped := true
var is_paused := false
var in_warning := false
var is_tweening := false

func _process(delta: float) -> void:
	if !is_stopped and !is_paused:
		time_elapsed += delta
		var minutes := time_elapsed / 60
		var seconds := fmod(time_elapsed, 60)
		var millisec := fmod (time_elapsed, 1) * 100
		time_string = "%02d:%02d:%02d" % [minutes,seconds,millisec]
		text = time_string
		in_warning = minutes >= 5
	if in_warning and !is_tweening:
		blink(Color.RED)
	if is_paused and !is_tweening:
		blink(Color.TRANSPARENT)

func reset() -> void:
	# possibly save time_elapsed somewhere else before overriding it
	time_elapsed = 0.0
	is_stopped = false
	is_paused = false

func start() -> void:
	reset()
	is_stopped = false

func pause() -> void:
	is_paused = true

func stop() -> void:
	is_stopped = true

func resume() -> void:
	is_stopped = false
	is_paused = false
	

func blink(to_color: Color):
	is_tweening = true
	var tween = create_tween()
	tween.tween_property(self, "self_modulate", to_color, .5)
	tween.tween_property(self, "self_modulate", Color.WHITE, .5)
	tween.tween_callback(func(): is_tweening = false)
