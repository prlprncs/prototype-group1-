extends Area

var questActive = false
var currentQuestion = ""
var currentAnswer = ""

const QUEST_REWARD = 10

var questionDatabase = {
	"What is the capital of France?": "Paris",
	"What is the largest mammal in the world?": "Blue Whale",
	"What is the smallest country in the world?": "Vatican City"
}

func _ready():
	pass

func _on_QuestArea_body_entered(body):
	if body.has_method("answerQuestion") and questActive == false:
		questActive = true
		var keys = questionDatabase.keys()
		var question = keys[randi() % keys.size()]
		currentQuestion = question
		currentAnswer = questionDatabase[question]
		body.answerQuestion(question)

func checkAnswer(answer):
	if answer == currentAnswer:
		questActive = false
		var player = get_tree().get_root().get_node("Player")
		player.addScore(QUEST_REWARD)
	else:
		var player = get_tree().get_root().get_node("Player")
		player.displayMessage("Wrong answer! Try again.")
