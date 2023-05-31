extends CharacterBody2D

var teleport_distance = 200  # Расстояние, на которое происходит телепортация
var teleporting = false      # Флаг телепортации
var SPEED = 250
const JUMP_VELOCITY = -400
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim_sprite = $AnimatedSprite2D
const bulletPATH = preload("res://Scenes/bullet.tscn")

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		teleporting = true
		$AnimatedSprite2D.play("idle")

	if teleporting:
		# Получаем позицию мыши и телепортируемся к ней
		var target_position = get_global_mouse_position()
		var direction = target_position - position
		if direction.length() > teleport_distance:
			direction = direction.normalized() * teleport_distance
		position += direction

		teleporting = false  # Сбрасываем флаг телепортации
func _physics_process(delta):
	# Add the gravity.

	if not is_on_floor():
		velocity.y += gravity * delta

	else:
		if(velocity.x == 0):
			anim_sprite.play("idle")
		else:
			if(velocity.x > 0):
				anim_sprite.play("walk right")
			else:
				anim_sprite.play("walk left")

	if Input.is_action_just_pressed('ui_space') and is_on_floor():
		velocity.y += JUMP_VELOCITY
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

#extends CharacterBody2D
#
#var SPEED = 250
#const JUMP_VELOCITY = -400
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#@onready var anim_sprite = $AnimatedSprite2D
#const bulletPATH = preload("res://Scenes/bullet.tscn")
#
#func shoot():
#	var bullet = bulletPATH.instantiate()
#	get_parent().add_child(bullet)
#	bullet.position = $Node2D/Marker2D.global_position
#
#func _process(delta):
#	$Node2D.look_at(get_global_mouse_position())
#	if Input.is_action_just_pressed("shot"):
#		shoot()
#
#
#func _physics_process(delta):
#	# Add the gravity.
#
#	if not is_on_floor():
#		velocity.y += gravity * delta
#
#	else:
#		if(velocity.x == 0):
#			anim_sprite.play("idle")
#		else:
#			if(velocity.x > 0):
#				anim_sprite.play("walk right")
#			else:
#				anim_sprite.play("walk left")
#
#	if Input.is_action_just_pressed('ui_space') and is_on_floor():
#		velocity.y += JUMP_VELOCITY
#	var direction = Input.get_axis("ui_left", "ui_right")
#	if direction:
#		velocity.x = direction * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)
#
#	move_and_slide()
#
#
#func _on_timer_timeout():
#	pass # Replace with function body.
