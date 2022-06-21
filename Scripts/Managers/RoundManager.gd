extends Manager

# Referencja do klasy LevelData z danymi o aktualnym poziomie, należy ustawić na null przy powrocie do menu
var CurrentLevel : RoundData

var redTeamLostUnits = 0
var redTeamAliveUnits = 0

var blueTeamLostUnits = 0
var blueTeamAliveUnits = 0

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
	get_node("../GameManager").get_child(get_node("../GameManager").get_child_count() - 1).get_node("AudioPlayer/AudioStreamPlayer").volume_db = -10
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

func AddMobToLostUnits(var mob):
	if (mob.team.teamIndex == 0):
		blueTeamLostUnits += 1
	elif(mob.team.teamIndex == 1):
		redTeamLostUnits += 1

# Todo - Sprawdzenie do którego zespołu należał mob
func OnMobKilled(mob):
	print(mob)
	
func OnteamDied(teamIndex):
	var wonBet = GameManager.SelectedTeamIndex == teamIndex
	redTeamAliveUnits = CurrentLevel.GetMobManager().teams[0].mobs.size()
	blueTeamAliveUnits = CurrentLevel.GetMobManager().teams[1].mobs.size()
	
	PlayerProfileManager.CurrentSelectedProfile.IncrementTotalPlayedRounds()
	
	if(wonBet):
		PlayerProfileManager.CurrentSelectedProfile.AddMoney(GameManager.Bet * 2)
		PlayerProfileManager.CurrentSelectedProfile.AddNewResult(GameManager.Bet)
	else:
		PlayerProfileManager.CurrentSelectedProfile.AddNewResult(-GameManager.Bet)
	
	PlayerProfileManager.CurrentSelectedProfile.CalculateWinRatio()
	PlayerProfileManager.CurrentSelectedProfile.CalculateEloPoints()
	
	if (PlayerProfileManager.CurrentSelectedProfile.GetTotalWinRatio() >= 50):
		PlayerProfileManager.CurrentSelectedProfile.AddEloPoints(16)
	else:
		PlayerProfileManager.CurrentSelectedProfile.DecreaseEloPoints(8)
	
	print("Game manager LoadEndRoundScene")
	GameManager.LoadEndRoundScene(wonBet)

