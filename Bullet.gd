extends Area2D

signal inc_score

export (int) var speed
var velocity = Vector2()

func start(pos, dir):
	position = pos
	rotation = dir
	velocity = Vector2(speed, 0).rotated(dir)

func _process(delta):
	position += velocity * delta

func _on_Bullet_body_entered(body):
	if body.is_in_group('enemy'):
		body.explode()
		queue_free()
		emit_signal("inc_score")


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()