extends CharacterBody2D

@onready var animation_tree = $AnimationTree
var cowboy: CharacterBody2D
@export var SPEED: float = 200
var direction = Vector2.ZERO
var prevDirection = Vector2.ZERO
@onready var sling_position = $SlingPosition
var sling
var curve_bullet: PackedScene = preload("res://Enemies/Slinger/curve_bullet.tscn")
@onready var pivot_area = $PivotArea
var slingerTimer = Timer.new()
var nextsling = true


func _ready():
	animation_tree.active = true
	for child in get_tree().root.get_node("World").get_children():
		if child.name == "Cowboy":
			cowboy = child
	add_child(slingerTimer)
	slingerTimer.wait_time = 3.0
	slingerTimer.connect("timeout", timedout)

@onready var reference_rect = $ReferenceRect

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	animation_tree["parameters/blend_position"] = velocity
	if cowboy!=null:
		movement()
	move_and_slide()

func movement():
	var direction = position.direction_to(cowboy.position)
	var distance = position.distance_to(cowboy.position)
	if distance < 300.0:
		velocity = Vector2.ZERO
		animation_tree["parameters/blend_position"] = prevDirection
		if nextsling:
			slingerTimer.start()
			nextsling = false
			fire_bullet()
	else:
		prevDirection = velocity
		velocity = SPEED * direction

func fire_bullet():
	var pos = pivot_area.global_position + Vector2(randf() * pivot_area.size.x, randf() * pivot_area.size.y)
	sling = curve_bullet.instantiate()
	sling.p0 = sling_position.global_position
	sling.p1 = pos
	sling.p2 = cowboy.position
	sling.position = sling_position.global_position
	get_tree().get_root().add_child(sling)
	
	
func timedout():
	nextsling = true
	if sling != null:
		sling.queue_free()
