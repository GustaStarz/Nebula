extends Area2D
@export var pull_strength: float = 10000.0

func _physics_process(delta: float) -> void:
	for body in get_overlapping_bodies():
		if body.is_in_group("player"):
			var direction = global_position - body.global_position
			if direction.length() > 1.0:
				body.pull_velocity += direction.normalized() * pull_strength * delta
