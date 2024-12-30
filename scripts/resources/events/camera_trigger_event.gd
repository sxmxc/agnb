class_name CameraTriggerEvent extends Resource

signal on_event(CameraTrigger)

func trigger(area : CameraTrigger):
	on_event.emit(area)
	
