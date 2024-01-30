extends RigidBody3D

const SPEED = 20.0
var player_detected = false
var player = null
var health = 5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if player_detected:
		var move_direction = (player.global_position - global_position).normalized();
		apply_central_force(move_direction * SPEED)



func _on_hitbox_area_entered(body):
	if body.is_in_group("bullet"): 
		health -=1
		if health <= 0:
			queue_free()
			
		
	pass # Replace with function body.


func _on_player_detect_area_entered(body):
	if body.is_in_group("Player"):	
		player = body
		player_detected = true


func _on_player_detect_area_exited(body):
	if body.is_in_group("Player"):	
		player = null
		player_detected = false
