class_name MobAnimator
extends Node2D

var bodySpriteRenderer: AnimatedSprite
var frontHandSpriteRenderer: AnimatedSprite
var backHandSpriteRenderer: AnimatedSprite

func StartAnimation(animationName: String):
	bodySpriteRenderer.animation = animationName
	bodySpriteRenderer.frame = 0
	frontHandSpriteRenderer.animation = animationName
	frontHandSpriteRenderer.frame = 0
	backHandSpriteRenderer.animation = animationName
	backHandSpriteRenderer.frame = 0

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
