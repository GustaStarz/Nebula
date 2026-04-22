extends CanvasLayer
#@onready var circle : TextureProgressBar  = $lua
#@onready var rect : TextureProgressBar = $barra
#@onready var h_scroll_bar : HScrollBar = $Node/HScrollBar
#@onready  var progress_bar : ProgressBar = $Node/ProgressBar
#func _ready() -> void:
	#$AnimatedSprite2D.play("default")
	#
#func _process(delta: float) -> void:
	#progress_bar.value = h_scroll_bar.value
	#rect.value = progress_bar.value
	#circle.value = progress_bar.value



@onready var circle: TextureProgressBar = $lua
@onready var rect: TextureProgressBar = $barra
@onready var progress_bar: ProgressBar = $Node/ProgressBar

# Referência ao player — ajuste o caminho conforme sua cena
@onready var player = get_tree().get_first_node_in_group("player")

func _ready() -> void:
	$AnimatedSprite2D.play("default")
	
	# Configura os limites das barras
	progress_bar.min_value = 0
	progress_bar.max_value = 100
	
	# Conecta o sinal do player à UI
	if player:
		player.hp_changed.connect(_on_hp_changed)
		_on_hp_changed(player.current_hp)  # Inicializa com HP atual
	else:
		push_warning("UI: Player não encontrado!")

func _on_hp_changed(new_hp: float) -> void:
	progress_bar.value = new_hp
	rect.value = new_hp
	circle.value = new_hp
# --------------------------------

	_update_sprite(new_hp)

func _update_sprite(hp: float) -> void:
	var percent = (hp / player.max_hp) * 100.0
	if hp <=0:
		$AnimatedSprite2D.play("dead")
	elif percent <= 10:
		$AnimatedSprite2D.play("critico")    # 10% ou menos
	elif percent <= 30:
		$AnimatedSprite2D.play("baixo")      # entre 11% e 30%
	elif percent <= 60:
		$AnimatedSprite2D.play("medio")      # entre 31% e 60%
	else:
		$AnimatedSprite2D.play("default")    # acima de 60%
