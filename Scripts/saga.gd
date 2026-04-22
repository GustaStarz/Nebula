extends CharacterBody2D
#código 100% humano
var acabou_pro_beta = false
func _process(delta: float) -> void:
	if acabou_pro_beta == true:
		$AnimatedSprite2D.play("atacano")
	else:
		$AnimatedSprite2D.play("default")

func _on_check_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		acabou_pro_beta = true

func _on_check_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		acabou_pro_beta = false
