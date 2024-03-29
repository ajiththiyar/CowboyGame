class_name Walk
extends State
@export var animation_tree: AnimationTree
var fire_allowed = true
@onready var bullet: PackedScene = preload("res://Player/bullet.tscn")
@onready var gun = $"../../Gun"
var gun_timer
@onready var dash_timeout = $"../../DashTimeout"
var dashdone = false
var dashCooldown := Timer.new()
@onready var collision_shape_2d = $"../../CollisionShape2D"

func _ready():
	set_physics_process(false)
	
func EXIT():
	set_physics_process(false)
	print("WalkExit")
	
func ENTER():
	print("WalkEnter")
	animation_tree.active = true
	set_physics_process(true)
	add_child(dashCooldown)
	dashCooldown.wait_time = 0.6
	dashCooldown.connect("timeout", on_timer_timeout)
	collision_shape_2d.disabled = false
	

func on_timer_timeout():
	actor.dashpermit = true

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction != Vector2.ZERO:
		setPrevDirection(direction)
		animation_tree["parameters/playback"].travel("movement")
		animation_tree.set("parameters/movement/blend_position",actor.prevDirection)
		handle_acceleration(direction, delta)
	else:
		handle_friction(direction)
		animation_tree["parameters/playback"].travel("idle")
		animation_tree.set("parameters/idle/blend_position",actor.prevDirection)
	if(Input.is_action_pressed("shoot")):
		if fire_allowed:
			fire()
			fire_allowed = false
	
	if actor.dashpermit:
		if(Input.is_action_pressed("dash") and dashdone == false):
			dash_timeout.start()
			dashdone = true
			actor.dashpermit = false
			dashCooldown.start()
			transitioned.emit(self, "dash")
			
		
	actor.move_and_slide()



func handle_acceleration(direction, delta):
	actor.velocity = direction* actor.speed

func handle_friction(direction):
	actor.velocity = direction

func fire():
	var bulletInstance = bullet.instantiate()
	bulletInstance.direction = actor.prevDirection
	bulletInstance.global_position = gun.global_position
	bulletInstance.global_rotation = actor.prevDirection.angle() + 90
	get_viewport().add_child(bulletInstance)

func setPrevDirection(direction):
	if direction.x > 0.7 or direction.x < -0.7 or direction.y > 0.7 or direction.y < -0.7:
		actor.prevDirection = direction
		
func _on_gun_timer_timeout():
	fire_allowed = true




func _on_dash_timeout_timeout():
	dashdone = false
