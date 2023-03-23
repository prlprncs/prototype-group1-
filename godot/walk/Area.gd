extends Area

var dialogue = "What is the capital of France?"
var answer = "Paris"
var interact_text = "Press 'E' to interact"



onready var player = get_node("/root/player")

func _ready():
	var interact_label = Label.new()
	interact_label.text = interact_text
	interact_label.align = Label.ALIGN_CENTER
	interact_label.rect_position = Vector2(0, -50)
	add_child(interact_label)

func _input(event):
	if event.is_action_pressed("ui_accept") :
		var question_box = load("res://DialogBox.tscn").instance()
		get_tree().get_root().add_child(question_box)
		question_box.set_text(dialogue)   
		question_box.connect("answered", self, "_on_answered")

func _on_answered(player_answer):
	if player_answer == answer:
		print("Correct!")
	else:
		print("Wrong answer.")


