
extends Panel

func _ready():
	pass

func _on_Timer_timeout():
	self.set_opacity(self.get_opacity() + 0.01)
	if(self.get_opacity() >= 1):
		var timer = get_node("Timer")
		timer.stop()
		get_tree().change_scene("res://Scenes/game_over.tscn")
