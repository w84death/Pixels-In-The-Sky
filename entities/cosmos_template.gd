
extends Sprite

const ASTEROIDS_DENISTY = 0.2

const MAX_SCREEN_X = 1024
const MAX_SCREEN_Y = 768

var GAME_SPEED = 100

var z_index = 0.1
var skin = 0
onready var pos = self.get_pos()

func _ready():
    randomize()
    self.random_skin()
    self.random_start_pos()

func random_start_pos():
    self.set_pos(Vector2(int(randi() % MAX_SCREEN_X), int(randi() % MAX_SCREEN_Y)))


func restart_pos():
    self.set_pos(Vector2(int(randi() % MAX_SCREEN_X), 0))

func random_skin():
    if ( randi() % 10 ) <= ASTEROIDS_DENISTY:
        skin = 3 + int(randi() % 5)
    else:
        skin = int(randi() % 3)
    self.set_frame(skin)
    z_index = (skin + 1) * 0.1
    self.set_z(z_index)

func move(delta):
    pos = self.get_pos()
    pos.y = pos.y + ( GAME_SPEED * delta * z_index )

    if pos.y > MAX_SCREEN_Y:
        self.restart_pos()
    else:
        self.set_pos(pos)