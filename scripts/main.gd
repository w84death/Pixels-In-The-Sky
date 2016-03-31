
extends Control

const GAME_SPEED = 1.0
const RIGHT = 1
const LEFT = 0
const GEN_COSMOS = 128

var player = null
var map = []

var player_template = preload('/entities/player_template.tscn')
var cosmos_template = preload('/entities/cosmos_template.tscn')

func _ready():
	self.player = self.player_template.instance()
	for i in range(0, GEN_COSMOS):
		self.map.append(self.cosmos_template.instance())
		self.add_child(self.map[i])

	self.player.set_pos(Vector2(512, 700))

	self.add_child(self.player)

	self.set_process(true)
	self.set_process_input(true)
	pass

func _process(delta):
	self.player.move(delta)
	for i in range(0, GEN_COSMOS):
		self.map[i].move(delta)
	return

func _input(event):
	if(event.type == InputEvent.KEY):
		if(event.scancode == KEY_RIGHT):
			self.player.move_ship(RIGHT)
		if(event.scancode == KEY_LEFT):
			self.player.move_ship(LEFT)