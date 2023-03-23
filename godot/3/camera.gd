extends Node3D

var camrot_h = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$h/v/SpringArm3D/Camera3D.get_parent_node_3d()

func _input(event):
	if event is InputEventMouseMotion:
		camrot_h += -event.relative.x
		
func _physics_process(_delta):
	
	$h.rotation_degrees.y = camrot_h
