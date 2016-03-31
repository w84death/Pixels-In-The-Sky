
extends Control

const RIGHT = 1
const LEFT = 0
const UP = 2
const DOWN = 3
const GEN_COSMOS = 128
const PLAYER_START_POS = [Vector2(256, 700), Vector2(767, 700)]
const MAX_PLAYERS = 2
var players = [null, null]
var map = []

var player_template = preload('/entities/player_template.tscn')
var cosmos_template = preload('/entities/cosmos_template.tscn')

func _ready():
	Globals.set("GAME_SPEED", 100)

	for i in range(0, GEN_COSMOS):
		self.map.append(self.cosmos_template.instance())
		self.add_child(self.map[i])

	for i in range(0, MAX_PLAYERS):
		self.players[i] = self.player_template.instance()
		self.players[i].set_pos(PLAYER_START_POS[i])
		self.add_child(self.players[i])

	self.set_process(true)
	self.set_process_input(true)
	pass

func _process(delta):
	for i in range(0, MAX_PLAYERS):
		self.players[i].move(delta)
	for i in range(0, GEN_COSMOS):
		self.map[i].move(delta)
	return

func _input(event):
	if(event.type == InputEvent.KEY):
		if(event.scancode == KEY_RIGHT):
			self.players[0].move_ship(RIGHT)
		if(event.scancode == KEY_LEFT):
			self.players[0].move_ship(LEFT)
		if(event.scancode == KEY_UP):
			self.players[0].move_ship(UP)
		if(event.scancode == KEY_DOWN):
			self.players[0].move_ship(DOWN)
		if(event.scancode == KEY_S):
			self.players[1].move_ship(RIGHT)
		if(event.scancode == KEY_A):
			self.players[1].move_ship(LEFT)