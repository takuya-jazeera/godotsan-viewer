extends Node2D

var mat
var scene 
var animCurrent = 0
var anims 

# Called when the node enters the scene tree for the first time.

func _ready():
	scene = $Node3D
	mat  = $Panel.material
	anims = $Node3D/SubViewport/godotsan2/AnimationPlayer.get_animation_list()
	$Panel.size = get_window().size
	mat.set_shader_parameter("tex",scene.get_node("SubViewport").get_texture())
	mat.set_shader_parameter("depth",scene.get_node("SubViewport2").get_texture())

	
	$Node3D/SubViewport/godotsan2/AnimationPlayer.play(anims[(animCurrent % anims.size())])
	$Node3D/SubViewport2/godotsan3/AnimationPlayer.play(anims[(animCurrent % anims.size())])			


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	animCurrent += 1
	$Node3D/SubViewport/godotsan2/AnimationPlayer.play(anims[(animCurrent % anims.size())])	
	$Node3D/SubViewport2/godotsan3/AnimationPlayer.play(anims[(animCurrent % anims.size())])		



func _on_check_button_toggled(toggled_on):
	print($Panel/CheckButton.button_pressed)
	mat.set_shader_parameter("bIsCelled",$Panel/CheckButton.button_pressed)


func _on_panel_gui_input(event):
	if event is InputEventMouseButton :
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			$Node3D.zoom = +0.1
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			$Node3D.zoom = -0.1
		else :
			$Node3D.zoom = 0.0
