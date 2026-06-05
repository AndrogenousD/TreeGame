extends Control
@onready var money_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/MoneyLabel
var speed_price=1.0
@onready var speed_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/SpeedButton
@onready var speed_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/SpeedLabel
@onready var buy_plant_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer2/BuyPlantButton
@onready var buy_plant_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer2/BuyPlantLabel
@onready var autoharvester_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer3/AutoharvesterButton
@onready var autoharvester_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer3/AutoharvesterLabel
@onready var value_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer4/ValueButton
@onready var value_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer4/ValueLabel


func _process(delta: float) -> void:
	money_label.text="Money: $"+str(global.money)

	speed_button.tooltip_text="Price: $"+str(speed_price)
	speed_label.text="Speed: "+str(global.plant_speed)
	
	buy_plant_button.tooltip_text="Price: $"+str(plant_price)
	buy_plant_label.text="Plants: "+str(plants)
	
	autoharvester_button.tooltip_text="Price: $"+str(auto_harvest_price)
	autoharvester_label.text="Auto-harvesters: "+str(autoharvesters)
	
	value_button.tooltip_text="Price: $"+str(value_upgrade_price)
	value_label.text="Value: $"+str(value)
func _on_speed_button_pressed() -> void:
	if global.money>=speed_price:
		global.plant_speed+=0.05
		global.money-=speed_price
		speed_price=snapped(speed_price+speed_price*0.5, 0.1)
		
const PLANT = preload("uid://dadgisia8hfkq")
@onready var grid_container: GridContainer = $MarginContainer/VBoxContainer/ScrollContainer/GridContainer
var plant_price=5
var plants=1
func _on_buy_plant_button_pressed() -> void:
	if global.money>=plant_price:
		var new=PLANT.instantiate()
		plants+=1
		grid_container.add_child(new)
		global.money-=plant_price
		plant_price=snapped(plant_price+plant_price*0.3, 0.1)
		
var auto_harvest_price=50.0
var autoharvesters=0

func _on_autoharvester_button_pressed() -> void:
	if global.money>=auto_harvest_price:
		for plant in grid_container.get_children():
			if not plant.auto_harvesting:
				plant.enable_auto_harvest()
				global.money-=auto_harvest_price
				auto_harvest_price=snapped(auto_harvest_price + auto_harvest_price * 0.5, 0.1)
				autoharvesters+=1

var value=1
var value_upgrade_price=500.0
func _on_value_button_pressed() -> void:
	if global.money>=value_upgrade_price:
		global.money-=value_upgrade_price
		global.value+=1
		value_upgrade_price=snapped(value_upgrade_price+value_upgrade_price*2, 0.1)
		value+=1
