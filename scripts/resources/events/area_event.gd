class_name AreaEvent extends Resource

signal on_event(Area2D)

func trigger(area : Area2D):
	on_event.emit(area)
