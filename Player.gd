extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var health = 100

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var spring_arm:SpringArm3D=$SpringArm3D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction =direction.rotated(Vector3.UP,spring_arm.rotation.y).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		$MeshInstance3D.rotation.y = lerp_angle($MeshInstance3D.rotation.y,atan2(direction.x,direction.z),delta*5)
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()



func _on_area_3d_area_entered(body):
	if body.is_in_group("Enemy"):	
		health -=10
		$ProgressBar.value=health
		
		if health==0: 
			$Panel.visible=true

