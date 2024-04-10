extends Node2D

var mat
var scene 
var animCurrent = 0
var anims 
# Called when the node enters the scene tree for the first time.

func _ready():
	scene = $Node3D
	mat  = $Panel.material
	anims = $Node3D/godotsan2/AnimationPlayer.get_animation_list()
	$Panel.size = get_window().size
	mat.set_shader_parameter("tex",scene.get_viewport().get_texture())
	
	$Node3D/godotsan2/AnimationPlayer.play(anims[(animCurrent % anims.size())])	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	animCurrent += 1
	$Node3D/godotsan2/AnimationPlayer.play(anims[(animCurrent % anims.size())])	
