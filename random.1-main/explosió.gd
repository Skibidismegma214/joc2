extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		$CPUParticles2D.emitting = true
		$CPUParticles2D/AudioStreamPlayer2D.playing = true
		
