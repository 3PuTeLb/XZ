extends Node2D

@onready var timer = $"dash timer"

func start_dash(dur):
	timer.wait_time = dur
	timer.start()
	
func is_dashing():
	return !timer.is_stopped()
