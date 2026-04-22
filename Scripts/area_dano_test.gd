extends Area2D

@export var damage: float = 50.0       # dano por toque
@export var continuous: bool = false  # dano contínuo ou só uma vez?
@export var damage_per_second: float = 10.0  # se contínuo

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		body.take_damage(damage)        # dano único ao entrar

func _on_body_exited(body: Node) -> void:
	pass  # pode usar para parar efeitos

func _process(delta: float) -> void:
	if continuous:
		# dano contínuo enquanto estiver na área
		for body in get_overlapping_bodies():
			if body.is_in_group("player"):
				body.take_damage(damage_per_second * delta)
