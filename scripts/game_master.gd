extends Control

func _ready() -> void:
	var button := $VBoxContainer/Button
	button.power_emitted.connect(_on_power_emitted)

func _on_power_emitted(power_type : String):
	if power_type == "za_warudo":
		print("ZA WARUDO!")
