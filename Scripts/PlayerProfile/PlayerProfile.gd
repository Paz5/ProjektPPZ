extends Node
class_name PlayerProfile

# string: Nazwa profilu
var profileName
# PlayerProfileData: Dane znajdujące się na danym profilu (lvl, pieniądze itp.)
var playerProfileData

# ======== Metody ========

# Inicjalizuje nowy profil
func _init(var profileName):
	self.profileName = profileName
	playerProfileData = PlayerProfileData.new()
	
# Wartości początkowe do nowo utworzonego profilu
func InitValues():
	SetLevel(1)
	SetMoney(120)
	SetEloPoints(100)
	SetTotalPlayedRounds(0)
	SetTotalWinRatio(0)
	SetRoundsResults([])

# Wartości z SaveData
func InitValuesFromSaveData():
	SetLevel(UpdateVariableFromSaveData("Level", 1))
	SetMoney(UpdateVariableFromSaveData("Money", 120))
	SetEloPoints(UpdateVariableFromSaveData("ELOPoints", 100))
	SetTotalPlayedRounds(UpdateVariableFromSaveData("TotalPlayedRounds", 0))
	SetTotalWinRatio(UpdateVariableFromSaveData("TotalWinRatio", 0))
	SetRoundsResults(UpdateVariableFromSaveData("RoundsResults", []))
	
	CalculateWinRatio()

# Aktualizuje wartość w dictionary SaveData
func UpdateValueInSaveData(var key, var value):
	playerProfileData.SaveData[key] = value

# Aktualizuje wartość zmiennej na podstawie wartości w dictionary, jeśli nie ma, to zwraca wartość domyślną
func UpdateVariableFromSaveData(var key, var defaultValue):
	if (playerProfileData.SaveData.has(key)):
		if(playerProfileData.SaveData[key] != null):
			return playerProfileData.SaveData[key]
		else:
			return defaultValue
			
	return defaultValue

# ======== Monety ========

# Dodanie "value" monet do profilu gracza
func AddMoney(var value : int): 
	playerProfileData.money += value
	UpdateValueInSaveData("Money", playerProfileData.money)
	PlayerProfileManager.SaveGame(profileName)

# Wydanie "value" monet z profilu gracza
func SpendMoney(var value : int):
	playerProfileData.money -= value
	UpdateValueInSaveData("Money", playerProfileData.money)
	PlayerProfileManager.SaveGame(profileName)

# Przypisanie "value" money do profilu gracza
func SetMoney(var value : int) :
	playerProfileData.money = value
	UpdateValueInSaveData("Money", playerProfileData.money)
	PlayerProfileManager.SaveGame(profileName)

# Pobranie aktualnej ilości monet
func GetCurrentMoney() -> int: return playerProfileData.money
	
# ======== Level ========

# Zwiększa poziom gracza o "value"
func AddLevel(var value : int):
	playerProfileData.level += value
	UpdateValueInSaveData("Level", playerProfileData.level)
	PlayerProfileManager.SaveGame(profileName)

# Przypisanie "value" do level gracza
func SetLevel(var value : int):
	playerProfileData.level = value
	UpdateValueInSaveData("Level", playerProfileData.level)
	PlayerProfileManager.SaveGame(profileName)

# Pobiera aktualny level gracza
func GetCurrentLevel() -> int: return playerProfileData.level

# ======== ELO Points ========

# Zwiększa punkty ELO o "value"
func AddEloPoints(var value : int):
	playerProfileData.eloPoints += value
	UpdateValueInSaveData("ELOPoints", playerProfileData.eloPoints)
	PlayerProfileManager.SaveGame(profileName)

# Przypisanie "value" do elo points
func SetEloPoints(var value : int):
	playerProfileData.eloPoints = value
	UpdateValueInSaveData("ELOPoints", playerProfileData.eloPoints)
	PlayerProfileManager.SaveGame(profileName)
	
# Zmniejszenie punktów ELO o "value"
func DecreaseEloPoints(var value : int):
	playerProfileData.eloPoints -= value
	UpdateValueInSaveData("ELOPoints", playerProfileData.eloPoints)
	PlayerProfileManager.SaveGame(profileName)

# Pobiera aktualne punkty ELO
func GetCurrentEloPoints() -> int: return playerProfileData.eloPoints

# ======== TotalWinRatio ========

# Obliczenie win ratio ze wszystkich rozgrywek
func CalculateWinRatio():
	var winRounds = 0
	var loseRounds = 0
	
	for i in GetRoundResults():
		if (i >= 0):
			winRounds = winRounds + 1
	
	if (winRounds > 0):
		playerProfileData.totalWinRatio = (float(winRounds) / playerProfileData.totalPlayedRounds) * 100
	elif (winRounds == 0):
		playerProfileData.totalWinRatio = 0
		
	UpdateValueInSaveData("TotalWinRatio", playerProfileData.totalWinRatio)
	PlayerProfileManager.SaveGame(profileName)	

# Przypisanie "value" do win ratio
func SetTotalWinRatio(var value : int):
	playerProfileData.totalWinRatio = value
	UpdateValueInSaveData("TotalWinRatio", playerProfileData.totalWinRatio)
	PlayerProfileManager.SaveGame(profileName)
	
# Pobiera aktualnego total win ration
func GetTotalWinRatio() -> int: return playerProfileData.totalWinRatio


# ======== Last10RoundsWinRatio ========

# ======== TotalPlayedRounds ========

# Zwiększa liczbę rozegrany wszystkich rund o 1
func IncrementTotalPlayedRounds():
	playerProfileData.totalPlayedRounds += 1
	UpdateValueInSaveData("TotalPlayedRounds", playerProfileData.totalPlayedRounds)
	PlayerProfileManager.SaveGame(profileName)

# Przypisanie "value" do TotalPlayedRounds
func SetTotalPlayedRounds(var value : int):
	playerProfileData.totalPlayedRounds = value
	UpdateValueInSaveData("TotalPlayedRounds", playerProfileData.totalPlayedRounds)
	PlayerProfileManager.SaveGame(profileName)
	
# Zwraca liczbę rozegranych rund
func GetTotalPlayedRounds() -> int: return playerProfileData.totalPlayedRounds

# ======== RoundsResults ========

# Dodaje nowy rezultat z ostatniej rundy
func AddNewResult(var balance):
	playerProfileData.roundsResults.resize(playerProfileData.roundsResults.size() + 1)
	playerProfileData.roundsResults[playerProfileData.roundsResults.size() - 1] = balance
	UpdateValueInSaveData("RoundsResults", playerProfileData.roundsResults)
	PlayerProfileManager.SaveGame(profileName)

# Przypisanie "value" do RoundsResults
func SetRoundsResults(var value : Array):
	playerProfileData.roundsResults = value
	UpdateValueInSaveData("RoundsResults", playerProfileData.roundsResults)
	PlayerProfileManager.SaveGame(profileName)
	
# Zwraca tablicę z rezultatem wszystkich meczy
func GetRoundResults() -> Array: return playerProfileData.roundsResults
