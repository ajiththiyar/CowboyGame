extends Marker2D
@onready var timer = $Timer

var canspawn = true

func _ready():
	canspawn = true
	timer.connect("timeout", spawnPermit)

	
func spawnPermit():
	canspawn = true
