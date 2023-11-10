extends Node3D


func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		get_parent().rotate(Vector3(0,1,0), 0.05)
	if Input.is_action_pressed("ui_right"):
		get_parent().rotate(Vector3(0,1,0), -0.05)
	if Input.is_action_pressed("ui_up"):
		var new_position = self.position + Vector3(0,.1,0)
		self.set_position(new_position)
	if Input.is_action_pressed("ui_down"):
		var new_position = self.position + Vector3(0,-.1,0)
		self.set_position(new_position)
