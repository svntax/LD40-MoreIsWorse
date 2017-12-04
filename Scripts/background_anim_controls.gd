
extends Node2D

var sprite

func _ready():
	sprite = get_node("Sprite")

func _on_Timer_timeout():
	var currentRegion = sprite.get_region_rect()
	var newX = currentRegion.pos.x + 1
	var newY = currentRegion.pos.y + 2
	if(newX >= 16):
		newX = 0
	if(newY >= 32):
		newY = 0
	sprite.set_region_rect(Rect2(Vector2(newX, newY), Vector2(16, 32)))

func _on_Timer_2_timeout():
	self.rotate(deg2rad(10))
