extends CharacterBody2D
const SPEED = 300
var direction = Vector2(0,0)
var atacando = false
func _physics_process(delta: float) -> void:
	mover()
	move_and_slide()
func mover():
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = SPEED * direction
	$AnimatedSprite2D.play("andano2")
	if atacando == true:
		$AnimatedSprite2D.play("atacano")
		
func atacano():
	if Input.is_action_just_pressed("test"):
		atacando = true
