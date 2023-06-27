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

# З Д О Р О В Ь Е
var health = 100

# С М Е Р Т Ь
@onready var death = $TextureRect

# П Р О Ц Е С С Ы
var playy = true

@onready var world = $"../objects"

func _physics_process(delta):
	if playy:
		update_health()
		
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
			
		if Input.is_action_just_pressed("damage"):
			health-=20
			printt(health)
	else:
		death.visible = true
		anim_sprite.visible = false
		world.visible = false
		
	move_and_slide()

func update_health():
	var healthbar = $HealthBar
	healthbar.value = health

func _on_regin_timer_timeout():
	if health < 100:
		if health > 100:
			health = 100
		if health <= 0:
			health = 0
			playy = false
		health += 4
