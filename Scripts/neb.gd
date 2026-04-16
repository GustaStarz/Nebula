extends CharacterBody2D
const SPEED = 300
var direction = Vector2(0,0)
var atacando = false
@export var projetil : PackedScene
@onready var ponta = $EmissorBala
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("test"):
		disparar()
		
func disparar():
	var nova_bala = projetil.instantiate()
	nova_bala.global_position = ponta.global_position
	nova_bala.direcao = (get_global_mouse_position() - global_position).normalized()
	get_tree().current_scene.add_child(nova_bala)
	atacando = true
func _physics_process(delta: float) -> void:
	if atacando:
		$AnimatedSprite2D.play("atacano")
	else:
		$AnimatedSprite2D.play("Andando3")
	mover()
	move_and_slide()
func mover():
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = SPEED * direction





func _on_animated_sprite_2d_animation_finished() -> void:
	if atacando:
		atacando = false
