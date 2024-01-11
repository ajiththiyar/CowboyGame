class_name Dash
extends State
@export var animation_tree: AnimationTree
@export var dashSpeed = 100
@onready var animation_player = $"../../AnimationPlayer"
@onready var collision_shape_2d = $"../../CollisionShape2D"

func _ready():
	set_physics_process(false)
func ENTER():
	set_physics_process(true)
	print("EnterDash")
	animation_tree.active = false
	animation_player.play("dash")
	collision_shape_2d.disabled = true

	
func EXIT():
	set_physics_process(false)
	animation_player.stop()
	print("ExitDash")

func _physics_process(delta):
	actor.position += actor.prevDirection * dashSpeed * delta
	actor.move_and_slide()

func _on_dash_timeout_timeout():
	transitioned.emit(self, "walk")

