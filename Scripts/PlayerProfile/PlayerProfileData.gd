extends Node
class_name PlayerProfileData

# Zmienne z danymi które zostaną zapisane/wczytane do/z pliku

# Wersja zapisu, jeśli będziemy chcieli robić konwerter aby starsze zapisy były kompatybilne z nowszymi wersjami
# Uwaga! Wersja zapisu != wersja gry
var saveVersion = "1.0" 
var level
var money
var eloPoints
var totalWinRatio
var last10roundsWinRatio
var totalPlayedRounds
var roundsResults
# Todo - Tablica z odblokowanymi mobami

# Dictionary<String, Value> 
# Nazwa, Wartość ze zmiennej
var SaveData = 	{
		"SaveVersion" : saveVersion,
		"Money" : money,
		"Level" : level,
		"ELOPoints" : eloPoints,
		"TotalWinRatio" : totalWinRatio,
		"Last10roundsWinRatio" : last10roundsWinRatio,
		"TotalPlayedRounds" : totalPlayedRounds,
		"RoundsResults" : roundsResults
	}
