
extends RigidBody2D

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	pass
	#if(is_colliding()):
		#print("Is colliding")
		#var other = get_collider()
		#if(other.is_in_group("pegs")):
			#print("Hit peg")
		#else:
			#print("Hit walls")

func _on_Ball_body_enter(body):
	if(body.is_in_group("pegs")):
		get_node("/root/sound_effects").play("clink_peg")
	elif(body.is_in_group("walls")):
		get_node("/root/sound_effects").play("thunk_bottom")
