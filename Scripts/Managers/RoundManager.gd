extends Manager

# Referencja do klasy LevelData z danymi o aktualnym poziomie, należy ustawić na null przy powrocie do menu
var CurrentLevel : RoundData

var redTeamLostUnits
var redTeamAliveUnits

var blueTeamLostUnits
var blueTeamAliveUnits

var timerStarted
var time = 0
var timerText

func _ready():
	GameManager.connect("mobKilled", self, "OnMobKilled")
	
func _process(delta):
	if (!timerStarted || timerText == null) : return
	
	time += delta
	timerText.text = String(time)

# Przygotowuje poziom, uruchamia timer
func PrepareLevel():
	var t = Timer.new()
	t.set_wait_time(0.1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	 
	timerStarted = true
	timerText = CurrentLevel.GetTimerObject()

# Resetuje wszystkie zmienne - należy wywołać po zakończeniu rundy
func Reset():
	redTeamLostUnits = 0
	redTeamAliveUnits = 0
	
	blueTeamLostUnits = 0
	blueTeamAliveUnits = 0
	
	time = 0
	timerStarted = false;
	
	CurrentLevel = null

# Todo - Sprawdzenie do którego zespołu należał mob
func OnMobKilled(mob):
	print(mob)
