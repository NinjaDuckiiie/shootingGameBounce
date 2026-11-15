extends CharacterBody2D

@export var player: CharacterBody2D
var speed = 500

func _physics_process(delta: float) -> void:
	velocity = global_position.direction_to(player.global_position) * speed
	move_and_slide()

var health = 4
func hurt(dmg):
	health -= dmg
	if health <=0:
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("damage"):
		body.damage(10)
