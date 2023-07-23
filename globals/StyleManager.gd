extends Node
## This global stores constants for how much style should be awarded for specific actions, 
## so that it's consistent everywhere.

const STYLE_FOR_BREAKING_WEAKPOINT : int = 25
const STYLE_FOR_HITTING_ENEMY : int = 1
const STYLE_FOR_KILLING_ENEMY : int = 10

func award_player_style(amount: int) -> void:
	PlayerInfo.current_player_shell.ghost_mount.ghost.style_points += amount
