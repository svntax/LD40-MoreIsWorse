
extends StaticBody2D

var sprite

func _ready():
	pass


func _on_Timer_timeout():
	self.rotate(deg2rad(10))
