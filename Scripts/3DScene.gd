# ----------------------------------
# Scripted by Takuya.S 2024
# under MIT License
# -----------------------------------

extends Node3D

var godot_san_anime
var animation_list

# latitude
var theta = 0.0
var dtheta = 0.0
# longtitude
var phi = 0.0
var dphi = 0.0

var current_mouse_position
const interpolate_interval = 2.0
var interpolate_lapse = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	#godot_san_anime = $godotsan2/AnimationPlayer
	#godot_san_anime.play("stand")
	# initialize first mouse position this prevents from 
	# camrea dancing
	quaternion = Quaternion(0.0,1.0,0.0,0.0)
	theta = PI * 0.5
	phi = PI * 0.5
	
	#animation_list = $godotsan2/AnimationPlayer.get_animation_list()
	#for x in animation_list :
	#	print (x)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#theta += delta 
	#$godotsan2.quaternion = Quaternion(0.0,cos(theta * 0.5),0.0,sin(theta * 0.5))
	var p = Quaternion(0.0,cos(theta),0.0,sin(theta))
	var q = Quaternion(0.0,cos(theta - dtheta),0.0,sin(theta - dtheta))
	
	var u = clamp (phi, PI*0.5 - 0.1, PI * 0.5 + 0.1)
	var v = clamp (phi - dphi, PI*0.5 - 0.1, PI * 0.5 + 0.1)
	var r = Quaternion(cos(u),0.0,0.0,sin(u))
	var s = Quaternion(cos(v),0.0,0.0,sin(v))
	
	
	var khi = interpolate_lapse / interpolate_interval
	$SubViewport/godotsan2.quaternion = p.slerp(q,khi) * r.slerp(s,khi)
	interpolate_lapse += delta
	
	if interpolate_lapse > interpolate_interval :	
		current_mouse_position = get_viewport().get_mouse_position()
		phi = clamp(dphi,-0.5,0.5) + PI * 0.5
		dtheta = (current_mouse_position.x - get_window().size.x * 0.5) * 0.0004
		dphi = clamp((current_mouse_position.y - get_window().size.y * 0.5) * 0.0002,-0.2,0.2)
