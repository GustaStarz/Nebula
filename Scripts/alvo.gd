extends Area2D

var hp: int = 10

func piscar_vermelho() -> void:
	var tween = create_tween()
	tween.set_loops(5)
	tween.tween_property(self, "modulate", Color(1.0, 0.0, 0.0, 0.886), 0.1)
	tween.tween_property(self, "modulate", Color(1, 1, 1, 1), 0.1)
	tween.finished.connect(func(): modulate = Color(1, 1, 1, 1))
	
		
#tem que ser area entered, body entered é só pra character body

func _ready() -> void:
	if $CollisionShape2D:
		area_entered.connect(_on_area_entered) # <- só Deus sabe como isso funciona


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bala"):
#		print ("entrou")
		piscar_vermelho()
		hp -= 1
		if hp <= 0:
			$AnimatedSprite2D.play("default")
			$AudioStreamPlayer2D.play()
			$Timer.start()


func _on_timer_timeout() -> void:
	queue_free()
#eu sou um gênio
