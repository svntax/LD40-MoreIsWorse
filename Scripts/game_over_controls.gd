
extends Node

var panel

func _ready():
	panel = get_node("Panel")

func _on_Timer_timeout():
	panel.set_opacity(panel.get_opacity() - 0.01)
	if(panel.get_opacity() <= 0):
		panel.set_opacity(0)
		var timer = get_node("Timer")
		timer.stop()
