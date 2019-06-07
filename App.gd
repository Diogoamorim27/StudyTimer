extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var timer : Timer = $Timer
onready var clock : Sprite = $Sprite2
onready var time_display : Label = $Time
onready var rest_button : Button = $Rest
onready var cicles_counter : Label = $Cicles
onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer

const WORK = 0
const REST = 1

var mode = WORK
var cicles = 0 
var time_left 
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = 25 * 60
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_left = timer.time_left
	clock.rotation_degrees = 360 * (1 - (timer.wait_time - timer.time_left)/timer.wait_time)
	var time_left_seconds = int(time_left) % 60
	var time_left_minutes = int(time_left / 60)
	print(time_left_seconds)
#	var time_left_minutes 
	
	var minutes_string = String(time_left_minutes)
	var seconds_string = String(time_left_seconds)
	if time_left_minutes < 10:
		minutes_string = "0" + String(time_left_minutes)
	if time_left_seconds < 10:
		seconds_string = "0" + String(time_left_seconds)
		
	time_display.text = minutes_string + ":" + seconds_string
#	pass


func _on_Start_pressed():
	if timer.is_stopped():
		timer.start()
	pass # Replace with function body.


func _on_Stop_pressed():
	timer.stop()
	pass # Replace with function body.


func _on_Rest_pressed():
	_toggle_mode()
	pass # Replace with function body.


func _on_Timer_timeout():
	audio_player.play()
	if mode == WORK:
		cicles += 1
		cicles_counter.text = "CICLES COMPLETED: " + String(cicles)
	_toggle_mode()
	pass # Replace with function body.

func _toggle_mode():
	timer.stop()
	if mode == WORK:
		rest_button.text = "work"
		timer.wait_time = 5 * 60
		mode = REST
		modulate = Color(0.407272, 0.733931, 0.847656)
	else:
		rest_button.text = "rest"
		timer.wait_time = 25 * 60
		mode = WORK
		modulate = Color(1, 1, 1)

