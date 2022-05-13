class_name MobAnimator
extends Node2D

export(NodePath) var bodySpritePath
export(NodePath) var frontHandSpritePath
export(NodePath) var backHandSpritePath
var bodySprite: AnimatedSprite
var frontHandSprite: AnimatedSprite
var backHandSprite: AnimatedSprite

var aimHands: bool = true
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
	if(target != null):
		if((global_position-target.global_position).x > 0):
			bodySprite.set_flip_h(true)
			frontHandSprite.set_flip_h(true)
			backHandSprite.set_flip_h(true)
		else:
			bodySprite.set_flip_h(false)
			frontHandSprite.set_flip_h(false)
			backHandSprite.set_flip_h(false)
		if(aimHands):
			frontHandSprite.look_at(target.global_position - Vector2(0,100))
			backHandSprite.look_at(target.global_position - Vector2(0,100))
			frontHandSprite.set_flip_h(false)
			backHandSprite.set_flip_h(false)
			if((global_position-target.global_position).x > 0):
				frontHandSprite.set_flip_v(true)
				backHandSprite.set_flip_v(true)
			else:
				bodySprite.set_flip_h(false)
				frontHandSprite.set_flip_v(false)
				backHandSprite.set_flip_v(false)
		
	bodySprite.z_index = global_position.y + 500
	frontHandSprite.z_index = global_position.y + 500 + 1
	backHandSprite.z_index = global_position.y + 500 - 1


func Idle():
	StartAnimation("Idle")
	aimHands = false

func Attack():
	StartAnimation("Attack")
	aimHands = true
	
func Death():
	StartAnimation("Death")
	aimHands = false
	
func Run():
	StartAnimation("Run")
	aimHands = false
	
func Win():
	StartAnimation("Win")
	aimHands = false


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
