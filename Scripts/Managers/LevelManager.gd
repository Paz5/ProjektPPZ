extends Manager

# Referencja do klasy LevelData z danymi o aktualnym poziomie, należy ustawić na null przy powrocie do menu
var CurrentLevel : LevelData

# Przygotowuje poziom, spawnuje przeciwników, resetuje liczniki, uruchamia timer
func PrepareLevel():
	for mob in CurrentLevel.MobsToSpawn:
		for i in CurrentLevel.MobsAmount:
			var mobNode = mob.instance()
			mobNode.position = Vector2(rand_range(0, 10), rand_range(0, 10))
