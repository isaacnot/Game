extends AnimatedSprite2D



func _on_button_mouse_entered() -> void:
	$".".play("hover")


func _on_button_mouse_exited() -> void:
	$".".play("default")


func _on_button_button_down() -> void:
	$".".play("press")


func _on_button_button_up() -> void:
	$".".play("default")
