extends CharacterBody2D


func _physics_process(delta: float) -> void:
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("hurt"):
		area.get_parent().hurt(2)
		queue_free()
