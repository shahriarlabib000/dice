extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_window().size)
	$dice.apply_torque($dice.basis.x * randi_range(-5000,5000))
	$dice.apply_torque($dice.basis.y * randi_range(-6000,6000))
	$dice.apply_torque($dice.basis.z * randi_range(-4600,4600))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	$Camera3D.look_at($dice.position)
	if Input.is_action_pressed("ui_accept"):
		$dice.apply_torque($dice.basis.x * randi_range(-500,500))
		$dice.apply_torque($dice.basis.y * randi_range(-600,600))
		$dice.apply_torque($dice.basis.z * randi_range(-460,460))
	if Input.is_action_just_pressed("gone") and $img.visible==false:
		$img.show()
		$boom.play()
		$dice.process_mode=Node.PROCESS_MODE_DISABLED
		$dice.position= Vector3(0,5,-3)
		$dice.process_mode=Node.PROCESS_MODE_INHERIT
		$dice.apply_torque($dice.basis.x * 5)
		await get_tree().create_timer(.1).timeout
		$img.hide()
		
	for Ray:RayCast3D in $dice/rays.get_children():
		if Ray.is_colliding():
			if Ray.get_collider().is_in_group("floor"):
				$number.text= Ray.name


func _on_area_3d_body_entered(body):
	if body.is_in_group("wall"):
		$dice/AudioStreamPlayer3D.play()
