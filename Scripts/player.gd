extends CharacterBody2D

var SPEED = 100
var JUMP_VELOCITY = -300
var ROLL_VELOCITY = -300

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $jumpSound
@onready var music: AudioStreamPlayer2D = $Music

var is_dead = false
var is_hit = false

func _physics_process(delta: float) -> void:
	if is_dead:
		move_and_slide()
		return
		
	if is_hit:
		return
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()
	
	# Get the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	if Input.is_action_just_pressed("roll") and is_on_floor():
		velocity.x = ROLL_VELOCITY * direction
	
	# Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		elif Input.is_action_pressed("roll"):  
			animated_sprite.play("roll")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func play_hit_then_dead_animation() -> void:
	is_hit = true  # Player is hit
	animated_sprite.play("hit")  # Play hit animation
	
	# Wait for the hit animation to finish before playing the dead animation
	await get_tree().create_timer(0.25).timeout  # Adjust the time to match your hit animation duration
	
	play_dead_animation()  # Now play the dead animation
	
	
# This function is now correctly placed outside of _physics_process
func play_dead_animation() -> void:
	is_dead = true
	music.stop()
	if not is_on_floor():
		velocity.y += 250
	if not is_on_ceiling():
		velocity.y += 250
	velocity.x = 0 
	animated_sprite.play("dead")
