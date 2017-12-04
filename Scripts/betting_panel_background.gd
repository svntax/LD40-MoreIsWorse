
extends Panel

func _ready():
	set_process(true)

func _process(delta):
	var container = get_parent().get_node("VBoxContainer");
	self.set_size(Vector2(container.get_size().width + 12, container.get_size().height + 12))
	centerDisplay()

func centerDisplay():
	get_parent().set_pos(Vector2(320, 240) - (self.get_size() / 2))