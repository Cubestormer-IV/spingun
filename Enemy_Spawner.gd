extends Node

onready var Enemy = preload("res://Enemy.tscn")

func spawn():
	randomize()
	$Path2D/PathFollow2D.set_offset(randi())
	
	var enemy = Enemy.instance()
	add_child(enemy)
	
	enemy.position = $Path2D/PathFollow2D.position
	enemy.rotation = Vector2(0, 1).dot(Vector2(300, 400) - enemy.position)
	enemy.set_linear_velocity((Vector2(300, 400) - enemy.position) / 2)


func _on_Timer_timeout():
	spawn()


func _process(delta):
	pass