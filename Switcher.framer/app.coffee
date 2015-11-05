cursor = require "cursor"
cursor.addPressedState()

bg = new BackgroundLayer backgroundColor: "#fff"

canvas = new Layer
	width: 153
	height: 93
	backgroundColor: "#e3e3e3"
	borderRadius: 153
	borderWidth: 4
	borderColor: "#e3e3e3"
	clip: false
	
canvas.center()
window.onresize = ->
	canvas.center()

background = new Layer
	width: 153 - 8
	height: 93 - 8
	backgroundColor: "#fff"
	borderRadius: 153 - 8
	clip: false
	superLayer: canvas
background.centerX(-3.5)

green = new Layer
	width: 153
	height: 93
	backgroundColor: "#4CD964"
	borderRadius: 100
	borderWidth: 4
	opacity: 0
	clip: false
	superLayer: canvas
green.centerY(-3.5)
green.centerX(-3.5)

knob = new Layer
	width: 86
	height: 86
	backgroundColor: "#fff"
	borderRadius: 100
	style: 
		boxShadow: "0 8px 12px rgba(0, 0, 0, 0.12)"
		border: "2px solid rgba(0, 0, 0, 0.1)"
	superLayer: canvas
knob.centerY(-3.5)

knob.states.add
	off: {width: 86, x: 0}
	offTouch: {width: 100, x: 0}
	on: {width: 86, x: 60}
	onTouch: {width: 100, x: 46}
knob.states.switchInstant "off"
knob.states.animationOptions =
	curve: "spring(120, 20, 14)"

background.states.add
	minimize: {scale: 0}
background.states.animationOptions =
	time: 0.35
	
canvas.on Events.TouchStart, ->
	background.states.switch "minimize"
	if knob.states.current is "off"
		knob.states.switch "offTouch"
	else if knob.states.current is "on"
		knob.states.switch "onTouch"

bg.on Events.TouchEnd, ->
	if knob.states.current is "offTouch"
		knob.states.switch "off"
		background.states.switch "default"
	if knob.states.current is "onTouch"
		knob.states.switch "on"
	
canvas.on Events.TouchEnd, ->
	if knob.states.current is "offTouch"
		knob.states.switch "on"
	if knob.states.current is "onTouch"
		knob.states.switch "off"
		background.states.switch "default"

knob.on "change:x", ->
	if this.states.current isnt "onTouch"
		green.opacity = this.x / 60
		

					
			
	