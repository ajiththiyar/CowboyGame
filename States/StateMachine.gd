extends Node
class_name State_Machine

@export var initial_state: State
var current_state: State
var states: Dictionary = {}

func _ready():
	for state in get_children():
		if state is State:
			state.transitioned.connect(change_state)
			states[state.name.to_lower()] = state
	if current_state == null:
		current_state = initial_state
		current_state.ENTER()

func change_state(old_state, new_state_name: String):
	if old_state == null:
		return
	if current_state != old_state:
		return
	if states[new_state_name.to_lower()] != null:
		old_state.EXIT()
		current_state = states[new_state_name.to_lower()]
		current_state.ENTER()
