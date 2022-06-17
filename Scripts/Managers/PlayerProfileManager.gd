extends Manager

# Odwołanie do aktualnie wybranego profilu przez gracza
var CurrentSelectedProfile

# Ścieżka do pliku z zapisem
# Scieżka w Windowsie to: C:\Users\[Nazwa_Uzytkownika]\AppData\Roaming\Godot\app_userdata\ProjektPPZ
var pathToFileSave = "user://"

# Tworzenie nowego profilu
func CreateNewProfile(var profileName):
	CurrentSelectedProfile = PlayerProfile.new(profileName)
	CurrentSelectedProfile.InitValues()

func CheckProfileExist(var profileName):
	var file = File.new()
	return file.file_exists(pathToFileSave + profileName + ".sav")

# Zapisanie profilu z SaveData który jest serializowany i parsowany  do .json, szyfrowane by uniemożliwić prostą edycję pliku z zapisem, zapisywana do pliku GameSave.sav
# Klucz szyfrowania/deszyfrowania to: SmiesznyKlucz
# Jesli zdeycdujemy sie na trzymanie zapisu gry na jakimś serwerze trzeba usunąć szyfrowanie!
func SaveGame(var profileName):
	var toFile = to_json(CurrentSelectedProfile.playerProfileData.SaveData)
	
	var file = File.new()
	
	file.open_encrypted_with_pass(pathToFileSave + profileName + ".sav", File.WRITE, "SmiesznyKlucz")
	file.store_string(toFile)
	file.close()
	
	
func LoadGame(var profileName):
	CurrentSelectedProfile = PlayerProfile.new(profileName)
	var file = File.new()

	file.open_encrypted_with_pass(pathToFileSave + profileName + ".sav", File.READ, "SmiesznyKlucz")
	var fromFile = parse_json(file.get_as_text())
	CurrentSelectedProfile.playerProfileData.SaveData = fromFile
	CurrentSelectedProfile.InitValuesFromSaveData()
	
# todo - refactor
func LoadDataFromSave(var profileName):
	var playerProfile = PlayerProfile.new(profileName)
	var file = File.new()

	file.open_encrypted_with_pass(pathToFileSave + profileName + ".sav", File.READ, "SmiesznyKlucz")
	var fromFile = parse_json(file.get_as_text())
	playerProfile.playerProfileData.SaveData = fromFile
	return playerProfile.playerProfileData.SaveData
	
# Zwraca tablicę string z nazwami zapisanych profili
func GetAllSaveProfiles():
	var files = []
	var directory = Directory.new()
	
	directory.open(pathToFileSave)
	directory.list_dir_begin()
	
	while true:
		var file = directory.get_next()
		print_debug(file.get_extension())
		if (file == null or file.empty()):
			break
		elif file.get_extension() == "sav":
			files.append(file)
			
	directory.list_dir_end()
	
	return files
