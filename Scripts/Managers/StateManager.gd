extends Manager

# Stany w jakich aktualnie znajduje się gra
enum GameStates {
	SplashScreens,
	MainMenu,
	Gameplay
}

# Zmienia stan na inny podany w argumencie metody
func ChangeState(state : int) -> void:
	GameManager.CurrentGameState = state

# Zwraca aktualny stan gry
func GetCurrentState() -> int: return GameManager.CurrentGameState
