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

var timeSec=0
var timeMin=0
var timeHour=0

var timeSecStr=""
var timeMinStr=""
var timeHourStr=""

func _ready():
	GameManager.connect("mobKilled", self, "OnMobKilled")
	
func _process(delta):
	if (!timerStarted || timerText == null) : return
	
	time += delta
	timeSec = int(time)
	if timeSec>=60:
		timeSec=0
		timeMin+=1
		time = 0
	
	if timeMin>=60:
		timeMin=0
		timeHour+=1
		
	if timeSec<10:
		timeSecStr="0"+String(timeSec)
	else:
		timeSecStr=String(timeSec)
		
	if timeMin<10:
		timeMinStr="0"+String(timeMin)
	else:
		timeMinStr=String(timeMin)
	
	if timeHour<10:
		timeHourStr="0"+String(timeHour)
	else:
		timeHourStr=String(timeHour)
	
	timerText.text = timeHourStr+":"+timeMinStr+":"+timeSecStr

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

	SubscribeSignal(CurrentLevel.GetMobManager())

# Resetuje wszystkie zmienne - należy wywołać po zakończeniu rundy
func Reset():
	UnsinscribeSignal(CurrentLevel.GetMobManager())
	
	redTeamLostUnits = 0
	redTeamAliveUnits = 0
	
	blueTeamLostUnits = 0
	blueTeamAliveUnits = 0
	
	time = 0
	timerStarted = false;
	
	CurrentLevel = null

# Tworzy nasłuch na sygnału teamów
func SubscribeSignal(var mobManager):
	for team in mobManager.teams:
		team.connect ("teamDied", self, "OnteamDied")
	
# Odłącza nasłuch na sygnały z teamów po zakończeniu rundy	
func UnsinscribeSignal(var mobManager):
	for team in mobManager.teams:
		team.disconnect ("teamDied", self, "OnteamDied")

# Todo - Sprawdzenie do którego zespołu należał mob
func OnMobKilled(mob):
	print(mob)
	
func OnteamDied(teamIndex):
	var wonBet = GameManager.SelectedTeamIndex == teamIndex
	
	if(wonBet):
		PlayerProfileManager.CurrentSelectedProfile.AddMoney(GameManager.Bet * 2)
	
	print("Game manager LoadEndRoundScene")
	GameManager.LoadEndRoundScene(wonBet)
	#GameManager.Bet = 0
	

