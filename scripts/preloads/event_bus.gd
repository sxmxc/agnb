extends Node

signal game_over
signal player_died(player: Player)
signal player_lives_updated(amount)
signal player_keys_updated(amount)
signal player_coins_updated(amount)
signal level_begin
signal level_end
signal level_restart
signal checkpoint_reached(checkpoint)

func _ready():
	var sigs = get_signal_list()
	for sig in sigs:
		Signal(self, sig.name).connect(_on_signal_call.bind(sig.name))
	pass
	
func _on_signal_call(args = null, sig = null):
	print("Signal %s called" % str(sig))
