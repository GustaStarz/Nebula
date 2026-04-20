extends Area2D
@export var heal : float = 50

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		body.heal(heal)
		$AudioStreamPlayer2D.play()
#		queue_free()
