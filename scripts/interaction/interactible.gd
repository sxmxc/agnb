class_name Interactable extends Area2D

signal on_interacted(interactor : Interactor)

var _interact_callables : Dictionary = {}

func _ready():
    area_entered.connect(_on_area_entered)
    area_exited.connect(_on_area_exited)

func _on_area_entered(area : Area2D):
    if area is Interactor:
        area.indicator.show()
        assert(not _interact_callables.has(area), "Interactor already connected")
        var callable := Callable(self, "_on_interact").bind(area)
        _interact_callables[area] = callable
        area.on_interact.connect(callable)

func _on_area_exited(area : Area2D):
    if area is Interactor:
        area.indicator.hide()
        if _interact_callables.has(area):
            area.on_interact.disconnect(_interact_callables[area])
            _interact_callables.erase(area)

func _on_interact(interactor : Interactor):
    interactor.indicator.hide()
    on_interacted.emit(interactor)
