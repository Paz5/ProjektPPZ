extends Manager

# Aktualny stan gry
var CurrentGameState

# Aktualna scena
var CurrentScene

#Wartosc betu
var Bet

# Wybrany zespół który wygra
var SelectedTeam
# Todo - zamienić SelectedTeamIndex na SelectedTeam
var SelectedTeamIndex 

# Tablica ze scenami z których będzie losowana 1 na której odbędzie się bitwa
# Ważne! Todo: Sceny te muszą znajdować się w tym samym katalogu
var RoundScenes = ["TestLevel.tscn"]


# Sygnały
signal SceneChanged(oldScene, newScene)
signal mobKilled(mob)
signal allMobsDead
signal BetConfirmed

func _ready():
	# Początkowy stan gry, aktualnie startuje z menu głównego, jeśli w przyszłości zrobimy splash screeny to trzeba zmienic tu na splashe
	CurrentGameState = StateManager.GameStates.MainMenu
	
	# Ustawienie aktualnej sceny
	var root = get_tree().get_root()
	CurrentScene = root.get_child(root.get_child_count() - 1)
	
	#PlayerProfileManager.LoadGame()

# Uruchamia losową planszę z rundą na podstawie levelName
func PlayLevel():
	StateManager.ChangeState(StateManager.GameStates.Gameplay)
	
	var randScene = RoundScenes[RandomNumberGenerator.new().randf_range(0, RoundScenes.size())]
	
	var pathToScene = "res://Scenes/Levels/Test/" + randScene
	var scene = ResourceLoader.load(pathToScene)
	
	if scene == null:
		print_debug("Nie znaleziono sceny o nazwie " + randScene + " w ściezce: " + pathToScene)
		return

	var levelScene = scene.instance()
	add_child(levelScene)
	

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
func LoadEndRoundScene(var roundWon):
	
	RoundManager.Reset()
	
	var endScene = null
	
	if (roundWon):
		endScene = ResourceLoader.load("res://Scenes/UI/KoniecRundy.tscn")
		emit_signal("SceneChanged", "Runda", "KoniecRundyWygrana")
	else:
		endScene = ResourceLoader.load("res://Scenes/UI/Przegrana.tscn")
		emit_signal("SceneChanged", "Runda", "KoniecRundyPrzegrana")
		
	if endScene == null:
		print_debug("Nie znaleziono sceny o nazwie " + endScene + " w ściezce: res://Scenes/UI/")
		return
		
	var t = Timer.new()
	t.set_wait_time(3)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")

	var instanceScene = endScene.instance()
	add_child(instanceScene)	

# Ładowanie sceny z profilem gracza
func LoadPlayerProfile():
	get_tree().change_scene("res://Scenes/UI/PlayerProfile.tscn")
	emit_signal("SceneChanged", "MainMenuScene", "PlayerProfileScene")

# Ładowanie sceny leaderboaard
func LoadLeaderboard():
	get_tree().change_scene("res://Scenes/UI/Leaderboard.tscn")
	emit_signal("SceneChanged", "MainMenuScene", "LeaderboardScene")

# Zwalnia z pamięci wszystkie instacjonowane sceny tworzone w GameManagerze	
func UnloadAllChilds():
	for child in self.get_children():
		child.queue_free()
	
	
## Maciej: Do czego służą te sygnały? Są podobne w innych menagerach!
func OnMobKilled(mob : Mob):
	emit_signal("mobKilled", mob)
	
func OnAllMobsDead():
	emit_signal("allMobsDead")
	
func OnBetConfirmed():
	emit_signal("BetConfirmed")
