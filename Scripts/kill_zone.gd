extends Area2D

@onready var timer: Timer = $Timer
@onready var hurt_sound: AudioStreamPlayer2D = $hurtSound
@onready var game_over: AudioStreamPlayer2D = $GameOver

var is_player_dying = false

func _on_body_entered(body: Node2D) -> void:
	if not is_player_dying:
		is_player_dying = true 
		body.play_hit_then_dead_animation()  # First, play the hit animation
		print("Player hit and about to die!")
		
		hurt_sound.play()
		game_over.play()
		
		Engine.time_scale = 0.6
		#body.get_node("CollisionShape2D").queue_free()
		timer.start()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
	is_player_dying = false
