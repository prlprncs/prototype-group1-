extends KinematicBody

var direction = Vector3.FORWARD
var velocity = Vector3.ZERO
var strafe_dir = Vector3.ZERO
var strafe = Vector3.ZERO

var vertical_velocity = 0
var gravity = 20
var aim_turn = 0

var movement_speed = 0
var walk_speed = 1.5
var run_speed = 5
var acceleration = 6
var angular_acceleration = 7


func _input(event):
	if event is InputEventMouseMotion:
		aim_turn = -event.relative.x * 0.015
		
	if event is InputEventKey:
		if event.as_text() == "W" || event.as_text() == "S" || event.as_text() == "A" || event.as_text() == "D" || event.as_text() == "Space":
			if event.pressed:
				get_node("Control/" + event.as_text()).color = Color("1f0d84")
			else:
				get_node("Control/" + event.as_text()).color = Color("891010")

func _physics_process(_delta):
	if Input.is_action_pressed("aim"):
		$Control/aim.color = Color("1f0d84")
		if !$AnimationTree.get("parameters/roll/active"):
			$AnimationTree.set("parameters/aim_transition/current", 0)
	else:
		#$Control/A/Label.color = Color("891010")
		$AnimationTree.set("parameters/aim_transition/current", 1)
	
	

	
	var h_rot = $CamRoot/h.global_transform.basis.get_euler().y
	
	if Input.is_action_pressed("forward") ||  Input.is_action_pressed("backward") ||  Input.is_action_pressed("left") ||  Input.is_action_pressed("right"):
		
		
		
		direction = Vector3(Input.get_action_strength("left") - Input.get_action_strength("right"),
					0,
					Input.get_action_strength("forward") - Input.get_action_strength("backward"))
					
		strafe_dir= direction
		direction = direction.rotated(Vector3.UP, h_rot).normalized()	
		
		if Input.is_action_pressed("sprint") && $AnimationTree.get("parameters/aim_transition/current") == 1:
			movement_speed = run_speed
			$AnimationTree.set("parameters/Iwr_blend/blend_amount", lerp($AnimationTree.get("parameters/Iwr_blend/blend_amount"), 1, _delta * acceleration))
		else:
			movement_speed = walk_speed
		$AnimationTree.set("parameters/Iwr_blend/blend_amount", lerp($AnimationTree.get("parameters/Iwr_blend/blend_amount"), 0, _delta * acceleration))
	else:
		$AnimationTree.set("parameters/Iwr_blend/blend_amount", lerp($AnimationTree.get("parameters/Iwr_blend/blend_amount"), -1, _delta * acceleration))
		movement_speed = 0
		strafe_dir = Vector3.ZERO
		
		if $AnimationTree.get("parameters/aim_transition/current") == 0:
			direction = $CamRoot/h.global_transform.basis.z
		
		
		
	velocity = lerp(velocity, direction * movement_speed, _delta * acceleration)
	
	
		

	move_and_slide(velocity + Vector3.DOWN * vertical_velocity, Vector3.UP)
	
	if !is_on_floor():
		vertical_velocity += gravity * _delta
	else:
		vertical_velocity = 0
		
	if $AnimationTree.get("parameters/aim_transition/current") == 1:
		$mesh.rotation.y = lerp_angle($mesh.rotation.y, atan2(direction.x, direction.z) - rotation.y, _delta * angular_acceleration)
	else:
		$mesh.rotation.y = lerp_angle($mesh.rotation.y, $CamRoot/h.rotation.y, _delta * angular_acceleration)
		
	strafe = lerp(strafe, strafe_dir + Vector3.RIGHT * aim_turn, _delta * acceleration)
	
	$AnimationTree.set("parameters/strafe/blend_position", Vector2(-strafe.x, strafe.z))
	
	
		
	$Control/Label.text = "direction:" + String(direction)
	$Control/Label2.text = "direction.lenght():" + String(direction.length())
	$Control/Label3.text = "velocity():" + String(velocity)
	$Control/Label4.text = "velocity.lenght():" + String(velocity.length())
