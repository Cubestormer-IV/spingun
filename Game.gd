extends Node

var score = 0
var lives = 3
var damage = 1

func _ready():
	$Controls/Left.hide()
	$Controls/Right.hide()

func start():
	$Controls/Left.show()
	$Controls/Right.show()
	$HUD/Name.hide()
	$HUD/StartButton.hide()
	$Spawner/Timer.start()
	lives = 3
	score = 0

func game_over():
	$Controls/Left.hide()
	$Controls/Right.hide()
	$HUD/StartButton.show()
	$HUD/Name.text = "Game Over"
	$HUD/Name.align = 1
	$HUD/Name.valign = 1
	$HUD/Name.show()
	$Spawner/Timer.stop()

# warning-ignore:unused_argument
func _process(delta):
	update_live_HUD()
	update_score()

func update_score():
	$HUD/Score.text = str(score)

func update_live_HUD():
	if lives == 3:
		$HUD/Lives.texture = preload("res://SpaceShooterRedux/Lives/Heart1.png")
	if lives == 2:
		$HUD/Lives.texture = preload("res://SpaceShooterRedux/Lives/Heart2.png")
	if lives == 1:
		$HUD/Lives.texture = preload("res://SpaceShooterRedux/Lives/Heart3.png")
	if lives == 0:
		$HUD/Lives.texture = preload("res://SpaceShooterRedux/Lives/Heart4.png")
		game_over()


func _on_Player_shoot(bullet, pos, dir):
	var b = bullet.instance()
	b.start(pos, dir)
	add_child(b)
	b.connect("inc_score", self, "_on_hit_player")

func _on_StartButton_pressed():
	start()
	print("start")

func _on_hit_player():
	score += 1

func _on_Player_hurt():
	lives -= damage
	damage = 0
	$DamageTimer.start()

func _on_DamageTimer_timeout():
	damage = 1