extends Control

# Krystian - wczytanie statystyk w wejsciu do sceny z RoundManagera po walce 
func _ready():
	#Jednostki alive
	$BlueTeamContainer/TroopsAliveLabel.set_text(str("Troops lost : ",RoundManager.blueTeamAliveUnits))
	$RedTeamContainer/TroopsAliveLabel.set_text(str("Troops lost : ",RoundManager.redTeamAliveUnits))
	#Jednostki dead
	$BlueTeamContainer/TroopsLostLabel.set_text(str("Troops lost : ",RoundManager.blueTeamLostUnits))
	$RedTeamContainer/TroopsLostLabel.set_text(str("Troops lost : ",RoundManager.redTeamLostUnits))
