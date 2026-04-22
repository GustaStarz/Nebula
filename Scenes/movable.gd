extends CharacterBody2D
@onready var box = $"."


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		pass
