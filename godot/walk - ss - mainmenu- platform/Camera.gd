extends Spatial

var camroot_h = 0
var camroot_v = 0
var cam_v_min = -55
var cam_v_max = 75
var h_sensitivity = 0.1
var v_sensitivity = 0.1
var h_acceleration = 10
var v_acceleration = 10


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$h/v/camera.add_exception(get_parent())
	
func _input(event):
	if event is InputEventMouseMotion:
		camroot_h += -event.relative.x * h_sensitivity
		camroot_v += event.relative.y * v_sensitivity	
			
func _physics_process(_delta):
	
	camroot_v= clamp(camroot_v, cam_v_min, cam_v_max)
	$h.rotation_degrees.y = lerp($h.rotation_degrees.y, camroot_h, _delta * h_acceleration)	
	$h/v.rotation_degrees.x = lerp($h/v.rotation_degrees.x, camroot_v, _delta * v_acceleration)	
