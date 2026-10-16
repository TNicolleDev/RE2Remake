class_name Door 
extends Interactable

var is_open: bool = false
@export var is_locked: bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func interact() -> void:
	if is_locked:
		print("locked things here.")
		return
	if is_open:
		close()
		return
	if !is_open:
		open()
		return
func open()-> void:
		print("Opening...")
		is_open = true
		animation_player.play("open")

func close() -> void:
		print("Closing...")
		is_open = false
		animation_player.play("close")
