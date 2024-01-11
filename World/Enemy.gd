extends Node
class_name Enemy

var strength: int
var enemy:PackedScene

func setEnemy(s:int, p: PackedScene) -> Enemy:
	self.strength = s
	self.enemy = p
	return self

