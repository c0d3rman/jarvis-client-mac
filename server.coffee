io = require("socket.io") 29632
apl = require "applescript"

scripts =
	volume:
		up: (amount) -> "set volume output volume (output volume of (get volume settings) + #{amount}) --100%"
		down: (amount) -> "set volume output volume (output volume of (get volume settings) - #{amount}) --100%"
		set: (volume) -> "set volume output volume #{volume} --100%"
	misc:
		beep: () ->
			runApl "beep", "Beeped"
		
runApl = (script, callback) ->
	apl.execString script, (err, rtn) ->
		throw err if err
		if typeof callback == "function"
			callback rtn
		else
			console.log callback
			
scripts.misc.beep()

io.on "connection", (socket) ->
	console.log "Connection!"
	socket.on "volume up", (amount) ->
		runApl scripts.volume.up(amount), ->
			console.log 'Volume increased'
			scripts.misc.beep()
	socket.on "volume down", (amount) ->
		runApl scripts.volume.down(amount), ->
			console.log 'Volume lowered'
			scripts.misc.beep()
	socket.on "volume set", (volume) ->
		runApl scripts.volume.set(volume), ->
			console.log 'Volume set'
			scripts.misc.beep()