extends KinematicBody2D

const GRAVITY = 20
const SPEED = 200
const JUMP_HIGHT = -400
const ACCELERATION = 50
const MAX_SPEED = 200

var motion = Vector2()

var hasDoubleJump = false

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play('Run')
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play('Run')
	else:
		$Sprite.play('Idle')
		friction = true

	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HIGHT
			hasDoubleJump = false
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	elif Input.is_action_just_pressed("ui_up"):
		if !hasDoubleJump:
			motion.y = JUMP_HIGHT
			hasDoubleJump = true
			$Sprite.play('Jump')
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.2)
	else:
		if motion.y < 0:
			$Sprite.play('Jump')
		else:
			$Sprite.play('Fall')
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)

	motion = move_and_slide(motion, Vector2.UP)
	
	print('Loop -> Motion:', motion)
	pass