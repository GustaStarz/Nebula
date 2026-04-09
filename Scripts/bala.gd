extends Area2D
#Códigos 100% puros
func _physics_process(delta: float) -> void:
	position.x += 15
func _ready() -> void:
	$AnimatedSprite2D.play("default")
