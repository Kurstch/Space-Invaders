extends Area2D

var bodyBlocking = false

func isBodyBlocking():
	var bodies = get_overlapping_areas()
	return false
	for body in bodies:
		if body != null:
			bodyBlocking = true
		else:
			bodyBlocking = true
