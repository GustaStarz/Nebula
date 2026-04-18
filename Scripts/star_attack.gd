extends Area2D

var velocidade = 600
var direcao = Vector2.ZERO
func _physics_process(delta: float) -> void:
	position += velocidade * direcao * delta
func _ready() -> void:
	look_at(get_global_mouse_position())
	$AnimatedSprite2D.play("default")


func _on_timer_timeout() -> void:
	queue_free()
