
extends Control

var prompt
var debtPrompt
var debtButton
var moneyUI
var inputLine
var ball

#1 = normal
#2 = after 1st loan
#3 = after 2nd loan
var gamePhase = 1
var DEBT_AMOUNT = 999

func _ready():
	prompt = get_node("VBoxContainer").get_node("Prompt")
	debtPrompt = get_node("VBoxContainer").get_node("DebtPrompt")
	debtButton = get_node("VBoxContainer").get_node("DebtButton")
	moneyUI = get_parent().get_node("MoneyUI")
	inputLine = get_node("VBoxContainer").get_node("LineEdit")
	ball = get_parent().get_parent().find_node("Ball")

func restart():
	if(moneyUI.getMoney() > 0):
		prompt.set_text("How much would you like to bet?")
	else:
		prompt.set_text("Looks like you're out of money!")
		debtPrompt.show()
		debtButton.show()
		inputLine.hide()

func _on_LineEdit_text_entered(text):
	var amount = int(text)
	if(amount == 0):
		prompt.set_text("Please bet a positive amount of money.")
		inputLine.set_text("")
	else:
		var currentMoney = moneyUI.getMoney()
		if(amount > currentMoney):
			prompt.set_text("You don't have that much money!")
			inputLine.set_text("")
		elif(amount < 0):
			prompt.set_text("I'm not paying you to play.")
			inputLine.set_text("")
		else:
			inputLine.set_text("")
			if(gamePhase == 1): #Normal betting rules
				self.hide()
				get_parent().get_parent().makeBet(amount)
			else: #HAVE to bet all money
				if(amount < currentMoney):
					prompt.set_text("That's not RISKY enough!")
				else:
					self.hide()
					get_parent().get_parent().makeBet(amount)

func _on_DebtButton_pressed():
	var musicHandler = get_node("/root/music_handler")
	var normalBGM = musicHandler.find_node("NormalBGM")
	var secondBGM = musicHandler.find_node("SecondBGM")
	var thirdBGM = musicHandler.find_node("ThirdBGM")
	var distortedBGM = musicHandler.find_node("DistortedBGM")
	debtPrompt.hide()
	debtButton.hide()
	inputLine.show()
	prompt.set_text("How much would you like to bet?")
	moneyUI.gainDebt(DEBT_AMOUNT)
	DEBT_AMOUNT *= 10
	if(gamePhase == 1):
		VisualServer.set_default_clear_color(Color(0.2, 0.2, 0.2, 1.0))
		normalBGM.set_volume(0)
		secondBGM.set_volume(1)
		thirdBGM.set_volume(0)
		distortedBGM.set_volume(0)
		for tray in get_tree().get_nodes_in_group("trays"):
			if(tray.get_node("LoseSprite").is_hidden()):
				tray.get_node("GreedSprite").show()
				tray.get_node("WinSprite").set_opacity(0)
	elif(gamePhase == 2):
		VisualServer.set_default_clear_color(Color(0, 0, 0, 1.0))
		ball.get_node("Sprite").hide()
		ball.get_node("GreedSprite").show()
		for bgTile in get_tree().get_nodes_in_group("bg_tiles"):
			bgTile.get_node("AnimatedSprite").play()
	elif(gamePhase == 3):
		var fadePanel = get_parent().find_node("FadePanel")
		fadePanel.set_opacity(0.3)
		normalBGM.set_volume(0)
		secondBGM.set_volume(0)
		thirdBGM.set_volume(1)
		distortedBGM.set_volume(0)
		for bgTile in get_tree().get_nodes_in_group("bg_tiles"):
			bgTile.get_node("Timer 2").start()
	elif(gamePhase == 4):
		var fadePanel = get_parent().find_node("FadePanel")
		fadePanel.set_opacity(0.6)
		normalBGM.set_volume(0)
		secondBGM.set_volume(0)
		thirdBGM.set_volume(0)
		distortedBGM.set_volume(1)
		for tray in get_tree().get_nodes_in_group("trays"):
			tray.get_node("LoseSprite").show()
			tray.get_node("WinSprite").hide()
			tray.get_node("GreedSprite").hide()
			tray.get_node("Area2D").type = tray.get_node("Area2D").LOSE
		for peg in get_tree().get_nodes_in_group("pegs"):
			peg.get_node("Sprite").hide()
			peg.get_node("GreedSprite").show()
			peg.get_node("Timer").start()
	elif(gamePhase == 5):
		prompt.set_text("...")
		inputLine.hide()
		var fadePanel = get_parent().find_node("FadePanel")
		fadePanel.get_node("Timer").start()
		moneyUI.glitch()
	gamePhase += 1
