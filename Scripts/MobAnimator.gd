class_name MobAnimator
extends Node2D

var bodySpriteRenderer: AnimatedSprite
var frontHandSpriteRenderer: AnimatedSprite
var backHandSpriteRenderer: AnimatedSprite

var aimHands: bool
var target: Node2D

func StartAnimation(animationName: String):
	bodySpriteRenderer.animation = animationName
	bodySpriteRenderer.frame = 0
	frontHandSpriteRenderer.animation = animationName
	frontHandSpriteRenderer.frame = 0
	backHandSpriteRenderer.animation = animationName
	backHandSpriteRenderer.frame = 0

func _process(delta):
	if(aimHands):
		frontHandSpriteRenderer.look_at(target.position)

func Flip(state: bool):
	bodySpriteRenderer.set_flip_h(state)
	frontHandSpriteRenderer.set_flip_h(state)
	backHandSpriteRenderer.set_flip_h(state)

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
