extends Area2D

@export var checkpoint_id: int  # Unique ID for the checkpoint
var is_active = true  # To ensure the checkpoint can only be activated once

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and is_active:
		print("Checkpoint reached: ", checkpoint_id)
		body.current_checkpoint = checkpoint_id  # Update player's checkpoint
		is_active = false  # Deactivate the checkpoint after being passed

func _on_timer_timeout() -> void:
	print("Level Up!")
	get_tree().reload_current_checkpoint()
