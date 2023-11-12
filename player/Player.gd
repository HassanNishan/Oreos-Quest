extends KinematicBody2D

export (int) var acceleration = 500
export (int) var friction = 500
export (int) var speed = 100

var input_vector : Vector2 = Vector2.ZERO
var velocity : Vector2 = Vector2.ZERO

func _physics_process(delta):
	movement(delta)
	animation_handler()

func get_input():
	input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return input_vector.normalized()

func movement(delta):
	get_input()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	move()

func move():
	velocity = move_and_slide(velocity)

#This function is only for the test sprite
func animation_handler():
	var sprite_direction = get_input()
	if sprite_direction == Vector2.DOWN:
		$Sprite.frame = 0
	elif sprite_direction == Vector2.LEFT:
		$Sprite.frame = 1
	elif sprite_direction == Vector2.UP:
		$Sprite.frame = 2
	elif sprite_direction == Vector2.RIGHT:
		$Sprite.frame = 3
