extends CharacterBody3D
	
var _velocity := Vector3(0,0,0)
var _angular_velocity := .0
var fixed_radius : float

func _ready():
	self.fixed_radius = abs(self.position.x)
	
func _process(delta):
	self._apply_gravity_acceleration(delta)
	var ground_collision = self._move_and_collide_in_y(delta)
	
	if ground_collision:
		if Input.is_action_pressed("jump"):
			self._velocity += Vector3(0, 10, 0)
		elif Input.is_action_pressed("ui_left"):
			self._angular_velocity = -1
		elif Input.is_action_pressed("ui_right"):
			self._angular_velocity = 1
		else:
			self._angular_velocity = 0
	var rotation_movement = _calculate_rotation(delta)
	self.move_and_collide(rotation_movement)
	# Angle between Camera player needs to be same as Player and origin
	# all radial entities can use this trick
	$CameraOrigin.rotation.y = -1 * _current_theta()

func _apply_gravity_acceleration(delta) -> void:
	self._velocity += Vector3(0, -9.8 * delta * 2, 0)
	
func _move_and_collide_in_y(delta) -> KinematicCollision3D:
	var y_component = Vector3(0, self._velocity.y * delta, 0)
	return self.move_and_collide(y_component)

func _current_theta() -> float:
	var current_birdseye_vector = _birdseye_vector(self.position)
	return _theta_from_cartesian(current_birdseye_vector)	

func _calculate_rotation(delta : float):
	var current_birdseye_vector = _birdseye_vector(self.position)
	var current_theta = _theta_from_cartesian(current_birdseye_vector)	
	var new_theta = current_theta + self._angular_velocity * delta * -1
	var target_birdseye_vector = _cartesian_from_theta(new_theta)
	var birdseye_movement_vector = target_birdseye_vector - current_birdseye_vector
	return _from_birdseye_vector(birdseye_movement_vector)
	

func _birdseye_vector(vector3: Vector3) -> Vector2:
	return Vector2(vector3.x, vector3.z)
	
func _from_birdseye_vector(birdseye_vector: Vector2) -> Vector3:
	return Vector3(birdseye_vector.x, 0, birdseye_vector.y)

func _theta_from_cartesian(vector : Vector2) -> float:
	return atan(vector.y/vector.x)

func _cartesian_from_theta(theta : float) -> Vector2:
	return Vector2(self.fixed_radius * cos(theta), self.fixed_radius * sin(theta))
	
