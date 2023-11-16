extends KinematicBody2D

export (int) var acceleration = 500
export (int) var friction = 500
export (int) var full_speed = 100
export (int) var walk_speed = 100

var input_vector : Vector2 = Vector2.ZERO
var velocity : Vector2 = Vector2.ZERO
var sprite_direction = "Down"
var state = MOVE

enum {
	MOVE,
}

onready var animationPlayer = $AnimationPlayer

func _physics_process(delta):
	match state:
		MOVE:
			default(delta)

func default(delta):
	get_input()
	movement()
	sprite_direction_loop()
	
	if input_vector != Vector2.ZERO:
		animation_switch("walk")
		velocity = velocity.move_toward(input_vector * walk_speed, acceleration * delta)
	else:
		animation_switch("idle")
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

func get_input():
	var LEFT = Input.is_action_pressed("move_left")
	var RIGHT = Input.is_action_pressed("move_right")
	var UP = Input.is_action_pressed("move_up")
	var DOWN = Input.is_action_pressed("move_down")
	
	input_vector.x = -int(LEFT) + int(RIGHT)
	input_vector.y = -int(UP) + int(DOWN)

func movement():
	input_vector = input_vector.normalized()
	velocity = move_and_slide(velocity)

func sprite_direction_loop():
	match input_vector:
		Vector2.LEFT:
			sprite_direction = "Left"
		Vector2.RIGHT:
			sprite_direction = "Right"
		Vector2.UP:
			sprite_direction = "Up"
		Vector2.DOWN:
			sprite_direction = "Down"

func animation_switch(Animation):
	var new_animation = str(Animation, sprite_direction)
	if animationPlayer.current_animation != new_animation:
		animationPlayer.play(new_animation)
