extends MeshInstance3D

func animate(finalPos:Vector3) -> void:
	show()
	var tween := create_tween()
	tween.tween_property(self,"global_position", finalPos , 0.2)
	await tween.finished
	$scare.play()
	await get_tree().create_timer(5).timeout
	hide()
	
