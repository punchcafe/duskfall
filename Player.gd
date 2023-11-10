extends CharacterBody3D


func _ready():
	pass
	
var _velocity := Vector3(0,0,0)

func _process(delta):
	self._apply_gravity_acceleration(delta)
	var ground_collision = self._move_and_collide_in_y(delta)
	
	if ground_collision:
		if Input.is_action_pressed("jump"):
			self._velocity += Vector3(0, 10, 0)
		elif Input.is_action_pressed("ui_left"):
			self._velocity.x = 0.05
		elif Input.is_action_pressed("ui_right"):
			self._velocity.x = -0.05
		else:
			self._velocity.x = 0
	get_parent().rotate(Vector3(0,1,0), self._velocity.x)

func _apply_gravity_acceleration(delta) -> void:
	self._velocity += Vector3(0, -9.8 * delta * 4, 0)
	
func _move_and_collide_in_y(delta) -> KinematicCollision3D:
	var y_component = Vector3(0, self._velocity.y * delta, 0)
	return self.move_and_collide(y_component)
	
			
