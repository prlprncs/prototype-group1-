extends Control

#signal answered(answer: String)

func _on_ok_button_pressed():
	emit_signal("answered", $LineEdit.text)

func set_text(text: String):
	$Label.text = text
