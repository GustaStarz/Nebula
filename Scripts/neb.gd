extends CharacterBody2D

const SPEED = 300
var direction = Vector2(0,0)

@export var projetil : PackedScene
@onready var ponta = $EmissorBala
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("test"):
		disparar()
		
func disparar():
	var nova_bala = projetil.instantiate()
	nova_bala.global_position = ponta.global_position
	get_tree().current_scene.add_child(nova_bala)
	
func _physics_process(delta: float) -> void:
	mover()
	move_and_slide()
func mover():
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = SPEED * direction
	$AnimatedSprite2D.play("Andando3")
