class_name WaveSpawner
extends Node

var bandit: PackedScene = preload("res://Enemies/Bandit/bandit.tscn")
var slinger: PackedScene = preload("res://Enemies/Slinger/slinger.tscn")

var enemies: Dictionary = {}
var increasedDifficulty: int = 10
var Difficulty: int = 100
var currentDifficulty: int

func _ready():
	enemies[1] = Enemy.new().setEnemy(10, bandit) 
	enemies[2] = Enemy.new().setEnemy(20, slinger)
	currentDifficulty = Difficulty
	
func _process(delta):
	if currentDifficulty != 0:
		var enemy: Enemy = getRandomEnemy()
		
		if enemy.strength <= currentDifficulty:
			currentDifficulty -= enemy.strength
			var spawn = getSpawn()
			var e = enemy.enemy.instantiate()
			e.position = spawn.global_position
			get_node("Enemies").add_child(e)
			

func getSpawn():
	var spawns = get_children()
	var spawn
	while true:
		if spawn is Marker2D:
			return spawn			
		else:
			spawn = spawns[randi() % spawns.size()]
func getRandomEnemy():
	return enemies[randi_range(1,2)]
