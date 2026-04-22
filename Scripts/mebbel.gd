extends CharacterBody2D
@export var damage: float = 5.0
var player = null
const SPEED = 100
func _ready() -> void:
	$AnimatedSprite2D.play("default")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(damage)
func _physics_process(delta: float) -> void:
	
	if player:
		
		var direction = (player.global_position - global_position).normalized()
		
		if global_position.distance_to(player.global_position) > 105:
			velocity = SPEED * direction
		else:
			velocity = Vector2(0,0)
		
		rotation = direction.angle()
	move_and_slide()

func _on_follow_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body



func _on_follow_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = null
		
