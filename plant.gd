extends VBoxContainer


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var button: Button = $Button
@onready var texture_rect: TextureRect = $TextureRect
@onready var timer: Timer = $Timer

var plant_state="not grown"
var auto_harvesting=false

func enable_auto_harvest() -> void:
	auto_harvesting=true

func _on_button_pressed() -> void:
	#grow plant
	animation_player.speed_scale=global.plant_speed
	if plant_state=="not grown":
		_play_growth()
		button.text="..."
		button.disabled=true
		plant_state="grown"
	elif plant_state=="mature":
		_do_harvest()
		
func _play_growth() -> void:
	if global.value==1:
		animation_player.play("growth")
	elif global.value==2:
		animation_player.play("growth_upgrade_1")
	else:
		animation_player.play("growth_upgrade_2+")

func _do_harvest() -> void:
	texture_rect.texture=null
	global.money+=global.value
	plant_state="not grown"
	button.text="Grow"
	if auto_harvesting:
		animation_player.speed_scale=global.plant_speed
		_play_growth()
		button.text="..."
		button.disabled=true
		plant_state="grown"

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	button.disabled=false
	button.text="Harvest"
	plant_state="mature"
	if auto_harvesting:
		_do_harvest()
		
func _on_timer_timeout() -> void:
	pass
