
extends Control

var prompt
var moneyUI
var inputLine

func _ready():
	prompt = get_node("VBoxContainer").get_node("Prompt")
	moneyUI = get_parent().get_node("MoneyUI")
	inputLine = get_node("VBoxContainer").get_node("LineEdit")

func restart():
	prompt.set_text("How much would you like to bet?")

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
			self.hide()
			get_parent().get_parent().makeBet(amount)
