extends CanvasLayer

signal start_game

func show_message(text):
	$MessagesLabel.text = text
	$MessagesLabel.show()
	$MessageTimer.start()


func game_over():
	show_message("Game over")
	yield($MessageTimer, "timeout")
	$StartButton.show()
	$MessagesLabel.text = "Nochmals?"
	$MessagesLabel.show()
	
	
func update_score(score):
	$ScoreLabel.text = str(score)


func _on_MessageTimer_timeout():
	$MessagesLabel.hide()


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
