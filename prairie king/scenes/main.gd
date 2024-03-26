extends Node

var wave : int
var max_enemies : int
var lives : int

# Called when the node enters the scene tree for the first time.
func _ready():
	wave = 1
	lives = 3
	max_enemies = 10 # waves of enemies
	$Hud/LiveLabel.text = "x " + str(lives)
	$Hud/WaveLabel.text = "Wave:  " + str(wave)
	$Hud/EnemiesLabel.text = "x " + str(max_enemies)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_enemy_spawner_hit_p():
	#print("hit player")
	lives -= 1
	$Hud/LiveLabel.text = "x " + str(lives)
