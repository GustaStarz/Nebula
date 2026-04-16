extends CharacterBody2D
func _ready() -> void:
	$AnimatedSprite2D.play("default")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		pass
