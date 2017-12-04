
extends Node2D

var resetBall = false
var bettingPhase = true
var droppingPhase = false

var bettingUI
var moneyUI
var ball

var LEFT_BOUND = 204
var RIGHT_BOUND = 436
var MOVE_SPEED = 1

func _ready():
	bettingUI = get_node("CanvasLayer").get_node("BettingUI")
	moneyUI = get_node("CanvasLayer").get_node("MoneyUI")
	ball = find_node("Ball")
	#generateBackground()
	set_process(true)
	set_fixed_process(true)

func generateBackground():
	var bgTile = get_node("CanvasLayer").get_node("BackgroundTile")
	for i in range(40):
		for j in range(30):
			var tileClone = bgTile.duplicate()
			tileClone.set_pos(bgTile.get_pos() + Vector2(j * 16, i * 32))
			get_parent().add_child(tileClone)

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
		ball.set_mode(RigidBody2D.MODE_STATIC)
		ball.set_global_pos(Vector2(320, 52))
		ball.set_rot(0)
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
	ball.get_node("AnimatedSprite").show()
	ball.set_mode(RigidBody2D.MODE_STATIC)

func dropBall():
	ball.get_node("AnimatedSprite").hide()
	ball.set_mode(RigidBody2D.MODE_RIGID)
	ball.set_sleeping(false) #Very important otherwise ball won't drop
	#Add RNG to the dropping
	var push = (randi() % 2)
	if(push == 0):
		push = -1
	elif(push == 1):
		push = 1
	var pushScale = (randi() % 5) + 1
	ball.apply_impulse(Vector2(), Vector2(push * pushScale, 0))
	bettingPhase = false
	droppingPhase = false

func startNewGame():
	resetBall = true
	bettingPhase = true
	droppingPhase = false
	for tray in get_tree().get_nodes_in_group("trays"):
		tray.get_node("Area2D").reset()
	ball.entered = false