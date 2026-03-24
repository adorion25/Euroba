extends Button

var pause : bool
@export var interface : Interface

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause = false
	pressed.connect(changer_mode_pause)


func changer_mode_pause() -> void:
	pause = !pause
	interface.changer_mode_pause(pause)
	
	if pause :
		text = "Reprendre"
	else :
		text = "Pause"
