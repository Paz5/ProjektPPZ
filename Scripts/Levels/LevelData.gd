extends Node

enum LevelStatus {
	InProgress,
	Finished
}

# Klasa przechowująca informacje o danym poziomie
class_name LevelData

export (String) var LevelName
export (LevelStatus) var LevelStatusType
export (Array, Resource) var MobsToSpawn
export (int) var MobsAmount
