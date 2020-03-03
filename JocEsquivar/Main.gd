extends Node

export (PackedScene) var Mob
export (PackedScene) var Creep
var score

func _ready():
	randomize() 

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()



func _on_MobTimer_timeout():
	# Choose a random location on Path2D.
	$MobPath/MobSpawnLocation.set_offset(randi())
	# Create a Mob instance and add it to the scene.
	var aleatori = randi()%11+1
	
	
	if aleatori == 1 or aleatori == 2:
		var prova = Creep.instance()
		add_child(prova)
		# Set the mob's direction perpendicular to the path direction.
		var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
		# Set the mob's position to a random location.
		prova.position = $MobPath/MobSpawnLocation.position
		# Add some randomness to the direction.
		direction += rand_range(-PI / 4, PI / 4)
		prova.rotation = direction
		# Set the velocity (speed & direction).
		prova.linear_velocity = Vector2(rand_range(prova.min_speed, prova.max_speed), 0)
		prova.linear_velocity = prova.linear_velocity.rotated(direction)
		score += 2
		$HUD.update_score(score)
	else:
		var mob = Mob.instance()
		add_child(mob)
		# Set the mob's direction perpendicular to the path direction.
		var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
		# Set the mob's position to a random location.
		mob.position = $MobPath/MobSpawnLocation.position
		# Add some randomness to the direction.
		direction += rand_range(-PI / 4, PI / 4)
		mob.rotation = direction
		# Set the velocity (speed & direction).
		mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
		mob.linear_velocity = mob.linear_velocity.rotated(direction)
		score += 1
		$HUD.update_score(score)

	
	 

func _on_StartTimer_timeout():
	$MobTimer.start()
	

# warning-ignore:unused_argument
func _on_ScoreTimer_timeout(tipusmonstre):
	pass


func _on_HUD_start_game():
	new_game()
