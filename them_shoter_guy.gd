extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var recoil_velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var xDirection := Input.get_axis("left", "right")
	var yDirection := Input.get_axis("up", "down")
	
	if xDirection:
		velocity.x = xDirection * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if yDirection:
		velocity.y = yDirection * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	velocity += recoil_velocity
	recoil_velocity = recoil_velocity.move_toward(Vector2.ZERO, 1200 * delta)
		
	move_and_slide()

var bulletscene = preload("res://bullet.tscn")
@export var bulletSpeed = 300
@export var shoot_cooldown = 0.5 # Cooldown set to 0.5 seconds
var bullets = 4
var spread = 20
var can_shoot = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click") and can_shoot:
		can_shoot = false
		
		var mousPos = get_global_mouse_position()
		var shootDir = global_position.direction_to(mousPos)
		
		recoil_velocity -= shootDir * 350
		
		for i in bullets:
			var newBullet = bulletscene.instantiate()
			var bulletDirection = shootDir.rotated(deg_to_rad(spread / 2 * (i - 1)))
			get_parent().add_child(newBullet)
			newBullet.global_position = global_position
			newBullet.look_at(mousPos)
			newBullet.velocity = bulletDirection * bulletSpeed
			
		await get_tree().create_timer(shoot_cooldown).timeout
		can_shoot = true

var health = 100

func _on_timer_timeout() -> void:
	if health < 100:
		health = min(health + 1, 100)
		$ProgressBar.value = health

func damage(dmg):
	health -= dmg
	$ProgressBar.value = health
	$Timer.start()
	if health <= 0:
		get_tree().reload_current_scene()
