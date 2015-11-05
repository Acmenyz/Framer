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
	width: 93
	height: 93
	backgroundColor: "#4CD964"
	borderRadius: Screen.width
	scale: 0
	clip: false
	superLayer: canvas
green.centerY(-3.5)
green.centerX(26)
green.states.add
	on: {scale: 30}
green.states.animationOptions =
	curve: "ease-in-out"
	time: 0.5

greenanimate1 = new Animation
	layer: green
	properties: 
		x: 0
		y: 0
		scale: 0
	curve: "ease-in-out"
	time: 0.4

greenanimate2 = new Animation
	layer: green
	properties: 
		x: 30
		y: 6
		scale: 5
	curve: "ease"
	time: 0.6
	
greenanimate3 = new Animation
	layer: green
	properties: 
		x: 30
		y: 6
		scale: 5.5
	curve: "ease"
	time: 0.6

wb = new Layer
	width: 153
	height: 93
	backgroundColor: "transparency"
	borderRadius: 153
	borderWidth: 4
	borderColor: "#e3e3e3"
	clip: false
	superLayer: canvas
wb.centerX(-3.5)
wb.centerY(-3.5)

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
		greenanimate2.start()
		greenanimate2.on(Events.AnimationEnd, greenanimate3.start)
		greenanimate3.on(Events.AnimationEnd, greenanimate2.start)
				
bg.on Events.TouchEnd, ->
	if knob.states.current is "offTouch"
		knob.states.switch "off"
		background.states.switch "default"
	if knob.states.current is "onTouch"
		knob.states.switch "on"
		green.states.switch "on"
	
canvas.on Events.TouchEnd, ->
	if knob.states.current is "offTouch"
		knob.states.switch "on"
		green.states.switch "on"
	if knob.states.current is "onTouch"
		knob.states.switch "off"
		background.states.switch "default"
		greenanimate1.start()
			
		greenanimate1.on Events.AnimationEnd, ->
			green.centerY(-3.5)
			green.centerX(26)

info1 = new Layer
	y: Screen.height - 100
	width: 130
	html: "Created by <a href='https://dribbble.com/Acmenyz'>Jiaxin</a>"
	backgroundColor: false
	opacity: 0.5

info1.style = 
	textAlign: "center"
	fontSize:	"16px"
	color:	"#888"
	fontFamily: "Avenir, Helvetica Neue"

info1.ignoreEvents = false
info1.centerX()