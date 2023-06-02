extends CharacterBody2D

# С К О Р О С Т Ь
var normSPEED = 250
var SPEED = normSPEED # скорость

# П Р Ы Ж К И
var JUMP_VELOCITY = -450 # сила прыжка
var JUMP_CONST = 0 # системная переменная ( не трогать )
var JUMP_MAX = 1 # максимум прыжков (дабл джамп = 1)
	
# Г Р А В И Т А Ц И Я
var gravity = 980 # сила гравитации

# А Н И М А Ц И Я
@onready var anim_sprite = $AnimatedSprite2D # анимация (walk right, walk left, idle)
	
# Р Ы В К И
const dashspeed = 2000
const dashlength = -1
@onready var dash = $Dash

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	var SPEED = dashspeed if dash.is_dashing() else normSPEED
		
	if(velocity.x == 0):
		anim_sprite.play("idle")
	else:
		if(velocity.x > 0):
			anim_sprite.play("walk right")
		else:
			anim_sprite.play("walk left")
	
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_pressed("dash"):
		dash.start_dash(dashlength)
		
	
	
	if Input.is_action_just_pressed('ui_space') and JUMP_CONST < JUMP_MAX:
		velocity.y = JUMP_VELOCITY
		JUMP_CONST += 1
		
	if is_on_floor():
		JUMP_CONST = 0

	move_and_slide()
