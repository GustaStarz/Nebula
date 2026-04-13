extends CharacterBody2D

const SPEED = 300
var direction = Vector2(0,0)
func _physics_process(delta: float) -> void:
	mover()
	move_and_slide()
func mover():
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = SPEED * direction
	$AnimatedSprite2D.play("Andando3")
