socketio = require "socket.io"
fs = require "fs"
https = require "https"
scripts = require "./applescripts"

options =
	key: fs.readFileSync "./certs/client.key"
	cert: fs.readFileSync "./certs/client.crt"	
app = https.createServer options
io = socketio.listen app
app.listen 29632

#, key: key, cert: cert, ca: ca #requestCert: false, rejectUnauthorized: false

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