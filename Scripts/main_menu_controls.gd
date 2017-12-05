
extends VBoxContainer

func _ready():
	pass

func _on_StartButton_pressed():
	var musicHandler = get_node("/root/music_handler")
	var normalBGM = musicHandler.find_node("NormalBGM")
	var secondBGM = musicHandler.find_node("SecondBGM")
	var thirdBGM = musicHandler.find_node("ThirdBGM")
	var distortedBGM = musicHandler.find_node("DistortedBGM")
	if(!normalBGM.is_playing() and !secondBGM.is_playing()):
		normalBGM.play()
		secondBGM.play()
		secondBGM.set_volume(0)
		thirdBGM.play()
		thirdBGM.set_volume(0)
		distortedBGM.play()
		distortedBGM.set_volume(0)
	get_tree().change_scene("res://Scenes/gameplay.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
