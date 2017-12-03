
extends Panel

func _ready():
	set_process(true)

func _process(delta):
	var container = get_parent().get_node("VBoxContainer");
	self.set_size(Vector2(container.get_size().width + 8, container.get_size().height + 8))
