class_name MobAnimator
extends Node2D

export(NodePath) var bodySpritePath
export(NodePath) var frontHandSpritePath
export(NodePath) var backHandSpritePath
var bodySprite: AnimatedSprite
var frontHandSprite: AnimatedSprite
var backHandSprite: AnimatedSprite

var aimHands: bool
var target: Node2D

func _ready():
	bodySprite = get_node(bodySpritePath)
	frontHandSprite = get_node(frontHandSpritePath)
	backHandSprite = get_node(backHandSpritePath)

func StartAnimation(animationName: String):
	bodySprite.animation = animationName
	bodySprite.frame = 0
	frontHandSprite.animation = animationName
	frontHandSprite.frame = 0
	backHandSprite.animation = animationName
	backHandSprite.frame = 0

func _process(delta):
	if(aimHands):
		frontHandSprite.look_at(target.position)
		backHandSprite.look_at(target.position)

func Flip(state: bool):
	bodySprite.set_flip_h(state)
	frontHandSprite.set_flip_h(state)
	backHandSprite.set_flip_h(state)

func Idle():
	StartAnimation("Idle")

func Attack():
	StartAnimation("Attack")
	
func Death():
	StartAnimation("Death")
	
func Run():
	StartAnimation("Run")
	
func Win():
	StartAnimation("Win")


func _on_MobStateMachine_transitioned(stateName):
	match(stateName):
		"MobIdleState":
			Idle()
		"MobAttackMeleeState":
			Attack()
		"MobDeathState":
			Death()
		"MobMoveState":
			Run()
		"MobWinState":
			Win()
