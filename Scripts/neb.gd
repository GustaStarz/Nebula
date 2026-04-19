extends CharacterBody2D
@onready var timer_morte: Timer = $Timer_morte
@onready var camera: Camera2D = $Camera2D  
const SPEED = 300
var direction = Vector2(0,0)
var atacando = false
var morto: bool = false
@export var projetil : PackedScene
@onready var ponta = $EmissorBala
#test---------------test---------------test----------
var sequencia_direcoes: Array = []
var ultima_direcao: String = ""
var easter_egg_ativo: bool = false
var contador_giros: int = 0
#test-----------test---------------test-------------
var invencivel: bool = false
@export var tempo_iframes: float = 1.0  # ajuste o tempo de invencibilidade
const SEQUENCIA_HORARIA = ["right", "down", "left", "up"]
const SEQUENCIA_ANTI_HORARIA = ["up", "left", "down", "right"]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		disparar()

func disparar():
	var nova_bala = projetil.instantiate()
	nova_bala.global_position = ponta.global_position
	nova_bala.direcao = (get_global_mouse_position() - global_position).normalized()
	get_tree().current_scene.add_child(nova_bala)
	atacando = true

func _physics_process(delta: float) -> void:
	mover()
#test-----------test
	registrar_direcao()
#test-------------test
	if morto:
		return 
	elif atacando:
		tocar_animacao_ataque()
#-------------------test----------------test--------------------test-------------------test--------------
	elif easter_egg_ativo:
		$AnimatedSprite2D.play("Especial")
		if direction == Vector2.ZERO:
			easter_egg_ativo = false
			contador_giros = 0
			$AnimatedSprite2D.play("Andando3")
	else:
		tocar_animacao_direcao()
#test------------------test-----------------test--------------test-------------------test-----------------
	move_and_slide()
func mover():
	if morto:
		velocity = Vector2.ZERO
		return
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = SPEED * direction

func tocar_animacao_ataque():
	$AnimatedSprite2D.play("atacano")

func tocar_animacao_direcao():
	if direction == Vector2.ZERO:
		return

	if abs(direction.y) >= abs(direction.x):
		if direction.y > 0:
			$AnimatedSprite2D.play("down")
		else:
			$AnimatedSprite2D.play("up")
	else:
		if direction.x > 0:
			$AnimatedSprite2D.play("Andando3")
		else:
			$AnimatedSprite2D.play("esq")
#test----------------test------------------test-------------------------test------------------test-------
func registrar_direcao():
	var dir_atual = pegar_direcao_cardinal()

	if dir_atual == "":
		sequencia_direcoes.clear()
		ultima_direcao = ""
		return

	if dir_atual != ultima_direcao:
		ultima_direcao = dir_atual

		if sequencia_direcoes.is_empty() or sequencia_direcoes.back() != dir_atual:
			sequencia_direcoes.append(dir_atual)

		if sequencia_direcoes.size() > 8:
			sequencia_direcoes.pop_front()

		checar_giro()

func pegar_direcao_cardinal() -> String:
	if direction == Vector2.ZERO:
		return ""
	if abs(direction.x) >= abs(direction.y):
		return "right" if direction.x > 0 else "left"
	else:
		return "down" if direction.y > 0 else "up"

func checar_giro():
	if sequencia_direcoes.size() < 4:
		return

	var ultimas = sequencia_direcoes.slice(sequencia_direcoes.size() - 4)

	if ultimas == SEQUENCIA_HORARIA or ultimas == SEQUENCIA_ANTI_HORARIA:
		contador_giros += 1
		sequencia_direcoes.clear()

		if contador_giros >= 3:
			easter_egg_ativo = true
			contador_giros = 0
# test-------------------test---------------------test---------------------test-----------------
func _on_animated_sprite_2d_animation_finished() -> void:
	if atacando:
		atacando = false

#-------------------------------------------------------------------------------------#
@export var max_hp: float = 100.0
var current_hp: float = max_hp

signal hp_changed(new_hp: float)
signal player_died()

func _ready() -> void:
	current_hp = max_hp
	$AnimatedSprite2D.play("Andando3")
	
	# Configura o timer de morte
	add_child(timer_morte)
	timer_morte.one_shot = true
	timer_morte.wait_time = 2.0  # ajuste o tempo conforme a duração do Vanish
	timer_morte.timeout.connect(_on_timer_morte_timeout)
func take_damage(amount: float) -> void:
	if invencivel or morto:
		return  # ignora dano durante iframes ou morte
	current_hp = clamp(current_hp - amount, 0, max_hp)
	emit_signal("hp_changed", current_hp)
	$AudioStreamPlayer2D.play()
	piscar_vermelho()
	if current_hp <= 0:
		die()

func piscar_vermelho() -> void:
	invencivel = true
	var sprite = $AnimatedSprite2D
	var tween = create_tween()
	tween.set_loops(5)  # quantas vezes pisca
	tween.tween_property(sprite, "modulate", Color(0.867, 0.0, 0.0, 0.502), 0.1)  # vai pro vermelho
	tween.tween_property(sprite, "modulate", Color(1, 1, 1, 1), 0.1)    # volta ao normal
	tween.finished.connect(func():
		sprite.modulate = Color(1, 1, 1, 1)  # garante que volta ao normal
		invencivel = false
	)
func heal(amount: float) -> void:
	current_hp = clamp(current_hp + amount, 0, max_hp)
	emit_signal("hp_changed", current_hp)

func die() -> void:
	morto = true
	emit_signal("player_died")
	$AudioStreamPlayer2D2.play()
	$AnimatedSprite2D.play("Vanish")
	timer_morte.start()
	zoom_morte()

func zoom_morte() -> void:
	var tween = create_tween()
	tween.tween_property(camera, "zoom", Vector2(1.5, 1.5), 0.5)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)
func _on_timer_morte_timeout() -> void:
	fade_e_trocar_cena()

func fade_e_trocar_cena() -> void:
	# CanvasLayer garante que fica por cima de tudo
	var canvas = CanvasLayer.new()
	get_tree().current_scene.add_child(canvas)
	
	var fade = ColorRect.new()
	fade.color = Color(0, 0, 0, 0)
	fade.set_anchors_preset(Control.PRESET_FULL_RECT)
	canvas.add_child(fade)
	
	var tween = create_tween()
	tween.tween_property(fade, "color", Color(0, 0, 0, 1), 2.0)\
		.set_trans(Tween.TRANS_LINEAR)
	tween.finished.connect(func():
		get_tree().change_scene_to_file("res://Scenes/gameover.tscn")
	)
