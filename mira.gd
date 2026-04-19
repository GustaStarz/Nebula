extends Node2D
@export var velocidade_rotacao = 1



var mira_ativa = false

func _ready():
	visible = false  # começa escondida

func _process(delta):
	if mira_ativa:
		rotation += velocidade_rotacao * delta  
		global_position = get_global_mouse_position()

func _input(event):
	if event.is_action_pressed("ativar_mira"):  # troque pelo seu botão
		mira_ativa = !mira_ativa
		visible = mira_ativa
		
		if mira_ativa:
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
