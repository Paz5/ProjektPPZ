extends Manager

# Aktualny stan gry
var CurrentGameState

# Aktualna scena
var CurrentScene

#Wartosc betu
var Bet

# Sygnały
signal SceneChanged(oldScene, newScene)

func _ready():
	# Początkowy stan gry, aktualnie startuje z menu głównego, jeśli w przyszłości zrobimy splash screeny to trzeba zmienic tu na splashe
	CurrentGameState = StateManager.GameStates.MainMenu
	
	# Ustawienie aktualnej sceny
	var root = get_tree().get_root()
	CurrentScene = root.get_child(root.get_child_count() - 1)
	
	PlayerProfileManager.LoadGame()

# Uruchamia poziom z gameplayem na podstawie levelName
func PlayLevel(var levelName : String):
	StateManager.ChangeState(StateManager.GameStates.Gameplay)
	
	var pathToScene = "res://Scenes/Levels/Test/" + levelName + ".tscn"
	var scene = ResourceLoader.load(pathToScene)
	
	if scene == null:
		print_debug("Nie znaleziono sceny o nazwie " + levelName + " w ściezce: " + pathToScene)
		return
	
	CurrentScene = scene.instance()
	
	get_tree().get_root().add_child(CurrentScene)
	
	LevelManager.CurrentLevel = CurrentScene.get_node("LevelData")


# Uruchamia główne menu
func LoadMainMenu():
	StateManager.ChangeState(StateManager.GameStates.MainMenu)
	
	get_tree().change_scene("res://Scenes/UI/MainMenuScene.tscn")
	emit_signal("SceneChanged", "KoniecRundy", "MainMenuScene")

# Ładowanie sceny z betem
func LoadBetScene():
	get_tree().change_scene("res://Scenes/UI/Obstawianie.tscn")
	emit_signal("SceneChanged", "MainMenuScene", "Obstawianie")
	
# Ładowanie sceny z końcem rundy
func LoadEndRoundScene():
	get_tree().change_scene("res://Scenes/UI/KoniecRundy.tscn")
	emit_signal("SceneChanged", "Obstawianie", "KoniecRundy")
	
