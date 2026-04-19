extends CharacterBody2D
@export var dialogue_resource: DialogueResource
var player_perto = false 
var ja_interagiu: bool = false
func _process(_delta: float) -> void:
	if player_perto and Input.is_action_just_pressed("dialogue_start"):
		ja_interagiu = true
		DialogueManager.show_dialogue_balloon(dialogue_resource, "start")
		if ja_interagiu:
			$Area2D.queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_perto = true




func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_perto = false
