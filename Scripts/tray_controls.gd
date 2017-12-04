
extends Area2D

var WIN = 1
var LOSE = 2
var type
var entered = false

func _ready():
	var winSprite = get_parent().get_node("WinSprite")
	var loseSprite = get_parent().get_node("LoseSprite")
	if(winSprite.is_hidden() and loseSprite.is_hidden()):
		print("ERROR: both win and lose sprites for tray are hidden")
		type = -1
	elif((not winSprite.is_hidden()) and (not loseSprite.is_hidden())):
		print("ERROR: both win and lose sprites for tray are shown")
		type = -1
	else:
		if(winSprite.is_hidden()):
			type = LOSE
		elif(loseSprite.is_hidden()):
			type = WIN

func setType(t):
	type = t;
	if type == WIN:
		get_parent().get_node("LoseSprite").hide()
		get_parent().get_node("WinSprite").show()
	elif type == LOSE:
		get_parent().get_node("LoseSprite").show()
		get_parent().get_node("WinSprite").hide()

#Called after a game ends/when a new game starts
func reset():
	entered = false

func _on_Area2D_body_enter( body ):
	if(self.get_instance_ID() != body.get_instance_ID()):
			if(body.is_in_group("balls") and not entered):
				var timer = get_parent().get_node("Timer")
				timer.start()
				entered = true

func _on_Timer_timeout():
	#Tray -> Board -> Game
	var scoreUI = get_parent().get_parent().get_parent().find_node("ScoreUI")
	if type == LOSE:
		#print("Lose")
		scoreUI.showLose()
	elif type == WIN:
		#print("Win")
		scoreUI.showWin()
