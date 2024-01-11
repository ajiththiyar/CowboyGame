extends CharacterBody2D
var cowboy: CharacterBody2D 
@export var SPEED = 200
var direction = Vector2.ZERO
@onready var animation_tree = $AnimationTree

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_tree().root.get_node("World").get_children():
		print(child.name)
		if child.name == "Cowboy":
			cowboy = child


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	animation_tree["parameters/move/blend_position"] = velocity
	if cowboy!= null:
		direction = position.direction_to(cowboy.position)
	else:
		direction = Vector2.ZERO
	velocity = SPEED * direction
	move_and_slide()


	



func _on_hitbox_body_entered(body):
	if body.has_method("player"):
		body.queue_free()
