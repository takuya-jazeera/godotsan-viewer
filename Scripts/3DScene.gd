# ----------------------------------
# Scripted by Takuya.S 2024
# under MIT License
# -----------------------------------

extends Node3D

var godot_san_anime
var animation_list

#var first_camera_position = position
@onready var camera = $SubViewport/Camera3D
@onready var camera2 = $SubViewport2/Camera3D2
@onready var camera_zoom_normal = $SubViewport/Camera3D.position.normalized()

# latitude
var theta = 0.0
var dtheta = 0.0
# longtitude
var phi = 0.0
#var dphi = 0.0

var zoom = 0.0

@onready var prev_rotation = $SubViewport/godotsan2.quaternion
@onready var next_rotation = $SubViewport/godotsan2.quaternion

var current_mouse_position
const interpolate_interval = 0.2
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
	#var p = Quaternion(0.0,cos(theta),0.0,sin(theta))
	#var q = Quaternion(0.0,cos(theta - dtheta),0.0,sin(theta - dtheta))
	
	current_mouse_position = get_viewport().get_mouse_position()
	var dphi = clamp((- current_mouse_position.y + get_window().size.y * 0.5) * 0.0002,-0.4,0.4)
	phi = dphi + PI * 0.5
	var u = clamp (phi, PI*0.5 - 0.1, PI * 0.5 + 0.1)
	var r = Quaternion(cos(u),0.0,0.0,sin(u))
	
	
	var khi = interpolate_lapse / interpolate_interval
	$SubViewport/godotsan2.quaternion = r * prev_rotation.slerp(next_rotation,khi)
	$SubViewport2/godotsan3.quaternion = $SubViewport/godotsan2.quaternion
	interpolate_lapse += delta
	
	if interpolate_lapse > interpolate_interval :	
		
		prev_rotation = next_rotation
		
		
		current_mouse_position = get_viewport().get_mouse_position()
		var d = current_mouse_position - get_window().size * 0.5
		if d.dot(d) < 90000.0 :
			#dphi = clamp((- current_mouse_position.y + get_window().size.y * 0.5) * 0.0002,-0.4,0.4)
			#phi = dphi + PI * 0.5
			theta = (-current_mouse_position.x + get_window().size.x * 0.5) * 0.002 + PI * 0.5;#=======

		dtheta = (current_mouse_position.x - get_window().size.x * 0.5) * 0.0004
		#dphi = clamp((current_mouse_position.y - get_window().size.y * 0.5) * 0.0002,-0.2,0.2)

		next_rotation = Quaternion(0.0,cos(theta),0.0,sin(theta))

		interpolate_lapse = 0.0

	camera.position += camera_zoom_normal * zoom
	camera2.position = camera.position
	
	$SubViewport2/godotsan3.position = $SubViewport/godotsan2.position
	zoom = 0.0
