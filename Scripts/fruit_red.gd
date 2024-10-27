extends Area2D

@onready var player: CharacterBody2D = %Player
@onready var power_up_red: AnimationPlayer = $PowerUpRed
@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("You collected a Jump boost!!")
	power_up_red.play("PowerUpSound")
	player.JUMP_VELOCITY = -400
	timer.start()
	
func _on_timer_timeout() -> void:
	print("Your Jump boost ran out!")
	player.JUMP_VELOCITY = -300
