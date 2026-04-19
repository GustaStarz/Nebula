extends Node2D

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/fase_1.tscn")
func _ready() -> void:
	var canvas = CanvasLayer.new()
	add_child(canvas)
	
	var fade = ColorRect.new()
	fade.color = Color(0, 0, 0, 1)  # começa opaco
	fade.set_anchors_preset(Control.PRESET_FULL_RECT)
	canvas.add_child(fade)
	
	var tween = create_tween()
	tween.tween_property(fade, "color", Color(0, 0, 0, 0), 3.0)\
		.set_trans(Tween.TRANS_LINEAR)
	tween.finished.connect(func():
		canvas.queue_free()
	)
	$AudioStreamPlayer.play()
