extends RigidBody2D

signal shoot
signal hurt

onready var Bullet = preload("res://Bullet.tscn")
var fire_rate = 0.3
#var lives = 3
var can_shoot = true

func _ready():
	$GunTimer.wait_time = fire_rate

# warning-ignore:unused_argument
func _process(delta):
	if linear_velocity.length() > 0:
		set_linear_velocity(Vector2(0, 0))
		emit_signal("hurt")

# warning-ignore:unused_argument
func _physics_process(delta):
	
	if Input.is_action_just_pressed("left"):
		set_applied_torque(-2500)
	elif Input.is_action_just_pressed("right"):
		set_applied_torque(2500)
	elif Input.is_action_pressed("left") and Input.is_action_pressed("right") and can_shoot:
		shoot()

func shoot():
	emit_signal("shoot", Bullet, $Muzzle.global_position, rotation - PI/2)
	can_shoot = false
	$GunTimer.start()

func _on_GunTimer_timeout():
	can_shoot = true

func _on_LiveTimer_timeout():
	pass