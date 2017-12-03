
extends Node2D

var resetBall = false
var bettingPhase = true
var droppingPhase = false

var bettingUI
var moneyUI
var ball

var LEFT_BOUND = 230
var RIGHT_BOUND = 410
var MOVE_SPEED = 1

func _ready():
	bettingUI = get_node("CanvasLayer").get_node("BettingUI")
	moneyUI = get_node("CanvasLayer").get_node("MoneyUI")
	ball = find_node("Ball")
	set_process(true)
	set_fixed_process(true)

func modeString(m):
	if(m == RigidBody2D.MODE_STATIC):
		return "STATIC"
	elif(m == RigidBody2D.MODE_RIGID):
		return "RIGID"
	elif(m == RigidBody2D.MODE_KINEMATIC):
		return "KINEMATIC"
	else:
		return "ERROR"

func _process(delta):
	if(bettingPhase):
		if(bettingUI.is_hidden()):
			bettingUI.show()
			bettingUI.restart()

func _fixed_process(delta):
	if(resetBall):
		resetBall = false
		ball.set_pos(Vector2(320, 32))
		ball.set_mode(RigidBody2D.MODE_STATIC)
		bettingPhase = true
		droppingPhase = false
	if(droppingPhase):
		if(Input.is_action_pressed("MOVE_LEFT")):
			var newPos = ball.get_pos() + Vector2(-MOVE_SPEED, 0)
			if(LEFT_BOUND < newPos.x):
				ball.set_pos(newPos)
		if(Input.is_action_pressed("MOVE_RIGHT")):
			var newPos = ball.get_pos() + Vector2(MOVE_SPEED, 0)
			if(newPos.x < RIGHT_BOUND):
				ball.set_pos(newPos)
		if(Input.is_action_pressed("DROP")):
			droppingPhase = false
			dropBall()

func makeBet(amount):
	moneyUI.bet(amount)
	bettingPhase = false
	droppingPhase = true
	ball.set_mode(RigidBody2D.MODE_KINEMATIC)

func dropBall():
	ball.set_mode(RigidBody2D.MODE_RIGID)
	ball.set_sleeping(false) #Very important otherwise ball won't drop
	bettingPhase = false
	droppingPhase = false

func startNewGame():
	resetBall = true
	bettingPhase = true
	droppingPhase = false
	for tray in get_tree().get_nodes_in_group("trays"):
		tray.get_node("Area2D").reset()