extends Actor

func _physics_process(delta):
	var move_direction = get_direction()
	velocity = calc_velocity(velocity,move_direction,speed)
	velocity = move_and_slide(velocity,FLOOR_NORMAL)

func get_direction():
	return Vector2(
		Input.get_action_strength("move_right")
		-Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0)

func calc_velocity(
	current_velocity:Vector2 ,
	direction:Vector2 , 
	speed:Vector2):
	
	var new_velocity = Vector2(
				current_velocity.x/1.2 ,
				current_velocity.y +gravity * get_physics_process_delta_time())
	if direction.y <= -0.9:
		new_velocity.y = direction.y*speed.y
	if abs(direction.x)> 0 and abs(new_velocity.x)< speed.x :
		new_velocity.x += direction.x*speed.x
	
	return new_velocity
	
