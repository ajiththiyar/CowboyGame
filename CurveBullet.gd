extends Area2D
var time = 0
@onready var animation_player = $AnimationPlayer
var p0
var p1
var p2

func bezier(t):
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var r = q0.lerp(q1, t)
	return r
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("fire")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position = bezier(time)
	time+=delta


func _on_hit_box_body_entered(body):
	if body.has_method("player"):
		body.queue_free()
