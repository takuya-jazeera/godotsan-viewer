extends SubViewport


# Called when the node enters the scene tree for the first time.
func _ready():
	var gdsan = $"godotsan3/rig/Skeleton3D/Godot-San"
	gdsan.material_override = load("res://Materials/depth.tres")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
