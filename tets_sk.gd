extends CharacterBody2D

# Г Р А В И Т А Ц И Я
var gravity = 980

# С К О Р О С Т Ь
var speed = 250

# П Р Ы Ж К И
var jump = 400
var jump_const = 0
var jump_max = 2

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("key_left"):
		velocity.x -= speed
	
		
	move_and_slide()
