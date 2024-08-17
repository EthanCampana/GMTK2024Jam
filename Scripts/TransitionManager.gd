class_name Transitions
extends CanvasLayer

@onready var l_slide = $LeftSlide
@onready var fade : ColorRect = $Fade
@onready var r_slide : = $RightSlide
@onready var anim : AnimationPlayer = $AnimationPlayer
var cur_animation : String


signal transition_in_finished



# Called when the node enters the scene tree for the first time.
func _ready():
	l_slide.visible = false
	r_slide.visible = false
	fade.visible = false

## Pass in a transition name to play in between scenes
## Params : transition_name : String [br]
## Transition Types ["slideIn","fadeIn]  Default : fadeIn
func transition(transition_name : String = "fadeIn"):
	match transition_name:
		"fadeIn":
			fade.visible = true
		"slideIn":
			l_slide.visible = true
			r_slide.visible = true
	cur_animation = transition_name
	anim.play(self.cur_animation)
	await anim.animation_finished
	emit_signal("transition_in_finished")

func transition_out():
	anim.play_backwards(self.cur_animation)
	await anim.animation_finished
	match cur_animation:
		"fadeIn":
			fade.visible = false 
		"slideIn":
			l_slide.visible = false 
			r_slide.visible = false 


