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

# Wartości z SaveData
func InitValuesFromSaveData():
	SetLevel(UpdateVariableFromSaveData("Level"))
	SetMoney(UpdateVariableFromSaveData("Money"))
	SetEloPoints(UpdateVariableFromSaveData("ELOPoints"))

# Aktualizuje wartość w dictionary SaveData
func UpdateValueInSaveData(var key, var value):
	playerProfileData.SaveData[key] = value

# Aktualizuje wartość zmiennej na podstawie wartości w dictionary
func UpdateVariableFromSaveData(var key):
	 return playerProfileData.SaveData[key]

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

# ======== Last10RoundsWinRatio ========

# ======== TotalPlayedRounds ========

