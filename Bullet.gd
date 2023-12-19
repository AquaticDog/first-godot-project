extends RigidBody3D

@export var intialForce =100


# Called when the node enters the scene tree for the first time.
func _ready(): 
	apply_central_impulse(global_transform.basis.z *intialForce) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
