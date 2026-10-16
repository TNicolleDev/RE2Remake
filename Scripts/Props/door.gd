class_name Door extends Interactable

@export var is_unlocked: bool = false

var can_interact = false

var is_closed: bool = true
var is_open: bool = false


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label_3d: Label3D = $DoorHinge/Label3D



func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_interact:
		interact()


func interact():
	check_if_locked()
	if !is_unlocked:
		return
	if is_closed:
		open()
		is_closed = false
		is_open = true
	else:
		close()
		is_closed = true
		is_open = false

func open() -> void:
	animation_player.play("open")
	
func close() -> void:
	animation_player.play("close")


func _on_area_3d_area_entered(_area: Area3D) -> void:
	can_interact = true
	change_label_visibility()



func _on_area_3d_area_exited(_area: Area3D) -> void:
	can_interact = false
	

func change_label_visibility():
	animation_player.play("animate_label")

func check_if_locked() -> void:
	if !is_unlocked:
		label_3d.text = "This is locked... You need to find the key."
		label_3d.visible = true
		await get_tree().create_timer(3.0).timeout
		label_3d.visible = false
		
		
