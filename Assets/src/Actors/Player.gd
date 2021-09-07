extends Actor

export var max_jump_count: int = 2
var _jump_count :int = 2

func _physics_process(delta):
	var input_direction = get_input_direction()
	_velocity = calc_velocity(_velocity,input_direction,speed)
	_velocity = move_and_slide(_velocity,FLOOR_NORMAL)

func get_input_direction():
	var y = 1.0 #means downwards / direction of gravity 
	var x = Input.get_action_strength("move_right")-Input.get_action_strength("move_left")

	if is_on_floor():
		_jump_count = max_jump_count
	
	if Input.is_action_just_pressed("jump") :
		if _jump_count > 0:
			y = -1.0
			_jump_count-=1

	return Vector2(x,y)

func calc_velocity(
	current_velocity:Vector2 ,
	direction:Vector2 , 
	speed:Vector2):

	var out = Vector2(
				direction.x * speed.x ,
				current_velocity.y +gravity * get_physics_process_delta_time())

	if direction.y == -1.0:
		out.y = direction.y*speed.y
	
	return out
	
