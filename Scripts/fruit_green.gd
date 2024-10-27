extends Area2D

@onready var player: CharacterBody2D = %Player
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("You collected a speed boost!!")
	animation_player.play("SpeedPower")
	player.SPEED = 200
	timer.start()
	
func _on_timer_timeout() -> void:
	print("Your speed boost ran out!")
	player.SPEED = 100
