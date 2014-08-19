apl = require "applescript"

runApl = (script, callback) ->
	apl.execString script, (err, rtn) ->
		throw err if err
		if typeof callback == "function"
			callback rtn
		else
			console.log callback

scripts =
	volume:
		up: (amount) ->
			runApl "set volume (output volume of (get volume settings) * (7 / 100) + #{amount} * (7 / 16))", "Increased volume by #{amount}"
		down: (amount) ->
			runApl "set volume (output volume of (get volume settings) * (7 / 100) - #{amount} * (7 / 16))", "Lowered volume by #{amount}"
		set: (amount) -> 
			runApl "set volume #{amount} * (7 / 16)", "Set volume to #{amount}"
		mute: () ->
			runApl "set volume with output muted", "Muted volume"
		unmute: () ->
			runApl "set volume without output muted", "Unmuted volume"
		toggleMute: () ->
			runApl """
				if output muted of (get volume settings)
					set volume without output muted
				else
					set volume with output muted
				end if
			""", "Mute toggled"
	misc:
		beep: () ->
			runApl "beep", "Beeped"
			
module.exports = scripts