extends Node2D

export (PackedScene) var Mob
var score
var MOB_MIN_SPEED = 150
var MOB_MAX_SPEED = 250

func _ready():
	randomize()
	
func new_game():
	score = 0
	$Player.start($StarPosition.position)
	$StartTimer.start()
	$HUD.show_message("Get Ready")
	$HUD.update_score(score)


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.game_over()


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_ScoreTimer_timeout():
	score += 1
	if score % 5 == 0 :
		MOB_MIN_SPEED += 20
		MOB_MAX_SPEED += 20
	$HUD.update_score(score)


func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.set_offset(randi())
	var mob = Mob.instance()	
	add_child(mob)
	var direction = $MobPath/MobSpawnLocation.rotate
	mob.position = $MobPath/MobSpawnLocation.position
	direction = rand_range(-PI/4, PI/4)
	mob.rotation = direction
	mob.set_linear_velocity(Vector2(rand_range(MOB_MIN_SPEED, MOB_MAX_SPEED),0).rotated(direction))