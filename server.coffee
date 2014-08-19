io = require("socket.io") 29632

scripts = require './applescripts'
			
scripts.misc.beep()

io.on "connection", (socket) ->
	console.log "Connection!"
	socket.on "volume up", (amount) ->
		scripts.volume.up(amount)
	socket.on "volume down", (amount) ->
		scripts.volume.down(amount)
	socket.on "volume set", (amount) ->
		scripts.volume.set(amount)
	socket.on "mute", (amount) ->
		scripts.volume.mute()
	socket.on "unmute", (amount) ->
		scripts.volume.unmute()
	socket.on "toggle mute", (amount) ->
		scripts.volume.toggleMute()