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
			return if amount.match /\D/
			runApl "set volume (output volume of (get volume settings) * (7 / 100) + #{amount} * (7 / 16))", "Increased volume by #{amount}"
			scripts.misc.beep()
		down: (amount) ->
			return if amount.match /\D/
			runApl "set volume (output volume of (get volume settings) * (7 / 100) - #{amount} * (7 / 16))", "Lowered volume by #{amount}"
			scripts.misc.beep()
		set: (amount) ->
			return if amount.match /\D/
			runApl "set volume #{amount} * (7 / 16)", "Set volume to #{amount}"
			scripts.misc.beep()
		mute: () ->
			runApl "set volume with output muted", "Muted volume"
		unmute: () ->
			runApl "set volume without output muted", "Unmuted volume"
			scripts.misc.beep()
		toggleMute: () ->
			runApl "return output muted of (get volume settings)", (muted) ->
				if muted == "true"
					scripts.volume.unmute()
				else
					scripts.volume.mute()
	misc:
		beep: () ->
			runApl "beep", "Beeped"
			
module.exports = scripts