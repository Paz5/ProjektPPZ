extends Manager

# Zmienne z danymi które zostaną zapisane/wczytane do/z pliku

# Wersja zapisu, jeśli będziemy chcieli robić konwerter aby starsze zapisy były kompatybilne z nowszymi wersjami
# Uwaga! Wersja zapisu != wersja gry
var saveVersion = "1.0" 
var money

# Dictionary<String, Value> 
# Nazwa, Wartość ze zmiennej
var SaveData = 	{
		"SaveVersion" : saveVersion,
		"Money" : money
	}


# Ścieżka do pliku z zapisem
# Scieżka w Windowsie to: C:\Users\[Nazwa_Uzytkownika]\AppData\Roaming\Godot\app_userdata\ProjektPPZ
var pathToFileSave = "user://GameSave.sav"

# ======== Metody ========

# Dodanie "value" monet do profilu gracza
func AddMoney(var value : int): money += value

# Przypisanie "value" money do profilu gracza
func SetMoney(var value : int) : money = value

# Pobranie aktualnej ilości monet
func GetCurrentMoney() -> int: return money;

# Zapisanie profilu z SaveData który jest serializowany i parsowany  do .json, szyfrowane by uniemożliwić prostą edycję pliku z zapisem, zapisywana do pliku GameSave.sav
# Klucz szyfrowania/deszyfrowania to: SmiesznyKlucz
# Jesli zdeycdujemy sie na trzymanie zapisu gry na jakimś serwerze trzeba usunąć szyfrowanie!
func SaveGame():
	
	var toFile = to_json(SaveData)
	
	var file = File.new()
	file.open_encrypted_with_pass(pathToFileSave, File.WRITE, "SmiesznyKlucz")
	file.store_string(toFile)
	file.close()
	
	
func LoadGame():
	
	var file = File.new()
	
	if not file.file_exists(pathToFileSave):
		print_debug("Nie odnaleziono pliku z zapisem gry! - zapisywanie")
		SaveGame()
		return
		
	
	file.open_encrypted_with_pass(pathToFileSave, File.READ, "SmiesznyKlucz")
	var fromFile = parse_json(file.get_as_text())
	SaveData = fromFile
