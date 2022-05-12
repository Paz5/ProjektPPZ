extends Manager

# Aktualny stan gry
var CurrentGameState

# Aktualna scena
var CurrentScene

#Wartosc betu
var Bet

# Wybrany zespół który wygra
var SelectedTeam 

# Tablica ze scenami z których będzie losowana 1 na której odbędzie się bitwa
# Ważne! Todo: Sceny te muszą znajdować się w tym samym katalogu
var RoundScenes = ["TestLevel.tscn"]


# Sygnały
signal SceneChanged(oldScene, newScene)
signal mobKilled(mob)
signal allMobsDead

func _ready():
	# Początkowy stan gry, aktualnie startuje z menu głównego, jeśli w przyszłości zrobimy splash screeny to trzeba zmienic tu na splashe
	CurrentGameState = StateManager.GameStates.MainMenu
	
	# Ustawienie aktualnej sceny
	var root = get_tree().get_root()
	CurrentScene = root.get_child(root.get_child_count() - 1)
	
	PlayerProfileManager.LoadGame()

# Uruchamia losową planszę z rundą na podstawie levelName
func PlayLevel():
	StateManager.ChangeState(StateManager.GameStates.Gameplay)
	
	var randScene = RoundScenes[RandomNumberGenerator.new().randf_range(0, RoundScenes.size())]
	
	var pathToScene = "res://Scenes/Levels/Test/" + randScene
	var scene = ResourceLoader.load(pathToScene)
	
	if scene == null:
		print_debug("Nie znaleziono sceny o nazwie " + randScene + " w ściezce: " + pathToScene)
		return
	
	CurrentScene = get_tree().change_scene(pathToScene)
		
	RoundManager.PrepareLevel()
	#RoundManager.CurrentLevel = CurrentScene.get_node("RoundData")


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
	
func OnMobKilled(mob : Mob):
	emit_signal("mobKilled", mob)
	
func OnAllMobsDead():
	emit_signal("allMobsDead")
