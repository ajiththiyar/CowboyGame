extends Node2D


var direction:Vector2
var speed:float =1000
@onready var animation_player = $AnimationPlayer
var alive = true
@onready var collision_shape_2d = $Hitbox/CollisionShape2D

func _ready():
	animation_player.play("fire")
	
	
func _physics_process(delta):
	if alive:
		if direction != Vector2.ZERO:
			position += direction * speed * delta
		else:
			position += Vector2.LEFT * speed * delta
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	if self != null:
		queue_free()


func _on_hitbox_body_entered(body):
	if body.is_in_group("enemy") and body != null:
		body.queue_free()
		alive = false
		animation_player.play("blood")
		self.get_node("Hitbox").queue_free()
		await animation_player.animation_finished
		if self != null:
			queue_free()
