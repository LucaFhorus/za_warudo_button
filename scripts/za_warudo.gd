extends Button

signal power_emitted(power_type: String)

@export var power_type : String
var is_time_stopped : bool
@onready var timer_label = Label.new()
@onready var progress_bar = $ProgressBar
@onready var grey_overscreen = $VideoStreamPlayer/ColorRect
@onready var video_player = $VideoStreamPlayer
var video_position

func _ready() -> void:
	pressed.connect(_on_pressed)
	$AudioStreamPlayer.connect("finished", _on_starter_sound_effect_finished)
	$AudioStreamPlayer2.finished.connect(_on_ending_sound_effect_finished)
	$Timer.connect("timeout", _on_stop_timer_ended)
	$Timer.one_shot = true
	$Timer2.connect("timeout", _on_one_second_passed)
	

func _process(_delta: float) -> void:
	var time_left = snappedf($Timer.time_left, 0.1)
	$Label2.text = str(time_left)
	timer_label.text = str($Timer2.time_left)
	

func _on_pressed():
	if is_time_stopped == false: 
		power_emitted.emit(power_type)
		$AudioStreamPlayer.play()
		is_time_stopped = true
		disabled = true
	else:
		return


func _on_starter_sound_effect_finished():
	print("_on_starter_sound_effect_finished")
	$Label.text = "Il tempo è bloccato"
	$Timer.start(5)
	$Timer2.start(1)
	video_player.paused = true
	grey_overscreen.visible = true

func _on_one_second_passed():
	$AudioStreamPlayer3.play()
	progress_bar.value = progress_bar.value + 1
	
func _on_stop_timer_ended():
	print("_on_stop_timer_ended")
	$Label.text = ""
	$AudioStreamPlayer2.play()
	$Timer2.stop()
	progress_bar.value = 0
	video_player.paused = false
	grey_overscreen.visible = false

func _on_ending_sound_effect_finished():
	disabled = false
	is_time_stopped = false
