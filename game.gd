extends Node2D

@export var player: CharacterBody2D

var enemy = preload("res://enemy_1.tscn")
func _on_timer_timeout() -> void:
	var newEnemy = enemy.instantiate()

	newEnemy.global_position = Vector2(randi_range(0, 1328), randi_range(0, 648))
	newEnemy.player = player 
	add_child(newEnemy)
	
var enemy2 = preload("res://enemy_2.tscn")
func _on_timer_2_timeout() -> void:
	var newEnemy2 = enemy2.instantiate()

	newEnemy2.global_position = Vector2(randi_range(0, 1328), randi_range(0, 648))
	newEnemy2.player = player 
	add_child(newEnemy2)
	
	
var enemy3 = preload("res://enemy_3.tscn")
func _on_timer_3_timeout() -> void:
	var newEnemy3 = enemy3.instantiate()

	newEnemy3.global_position = Vector2(randi_range(0, 1328), randi_range(0, 648))
	newEnemy3.player = player 
	add_child(newEnemy3)
	
	
