
extends Control

var money = 100
var debt = 0
var bet = 0

var moneyLabel
var debtLabel

func _ready():
	moneyLabel = get_parent().find_node("MoneyLabel")
	debtLabel = get_parent().find_node("DebtLabel")
	updateDisplay()
	set_process(true)

func _process(delta):
	#var camPos = get_parent().get_node("Ball").get_node("Camera2D").get_camera_pos()
	#self.set_global_pos(camPos - self.get_size())
	#print(self.get_global_pos())
	pass

func winMoney():
	if(bet == 0):
		print("ERROR: bet was somehow zero")
	money += bet * 2
	bet = 0
	updateDisplay()
	#TODO play sound for winning money

func bet(amount):
	money -= amount
	bet = amount
	updateDisplay()

func gainDebt(amount):
	debt += amount
	money += amount
	updateDisplay()
	updateDebtDisplay()

func getMoney():
	return money

func updateDisplay():
	moneyLabel.set_text("Money: $" + str(money))

func updateDebtDisplay():
	debtLabel.show()
	debtLabel.set_text("Debt: $" + str(debt))