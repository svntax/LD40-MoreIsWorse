
extends Control

var moneyUI
var winMessage
var loseMessage
var earnings

func _ready():
	moneyUI = get_parent().get_node("MoneyUI")
	winMessage = find_node("WinMessage")
	loseMessage = find_node("LoseMessage")
	earnings = find_node("Money")

#NO LONGER NEEDED because of CanvasLayer
func setPosToCenter():
	var cam = get_parent().find_node("Camera2D")
	var camPos = cam.get_camera_pos()
	var newPos = camPos - (get_node("VBoxContainer").get_size() / 2)
	self.set_global_pos(newPos)

func showWin():
	self.show()
	loseMessage.hide()
	winMessage.show()
	earnings.set_text("Earnings: +$" + str(moneyUI.bet))
	stopBall()

func showLose():
	self.show()
	loseMessage.show()
	winMessage.hide()
	earnings.set_text("Losses: -$" + str(moneyUI.bet))
	stopBall()

#Used so that the ball stops moving when the score UI pops up
func stopBall():
	var ball = get_parent().get_parent().find_node("Ball")
	ball.set_mode(RigidBody2D.MODE_STATIC)

func _on_Button_pressed():
	#CanvasLayer -> Game
	if(loseMessage.is_hidden()): #That means player won money
		moneyUI.winMoney()
	get_parent().get_parent().startNewGame()
	self.hide()
