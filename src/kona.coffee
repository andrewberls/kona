Kona = window.Kona = {}

# Debug helpers
# Set this to true to log info to the console
# Make sure to disable for production dists
Kona.debugMode = true

Kona.debug = (msg) ->
  console.log msg if Kona.debugMode

Kona.readyCallbacks = []
Kona.isReady = false


Kona.ready = (callback) ->
  if document.readyState == 'complete'
    Kona.isReady = true

  # If the DOM is already ready, just invoke the callback.
  if Kona.isReady
    callback.call()

  Kona.readyCallbacks.push(callback)


# Internal function hooked to the DOM's ready event.
Kona.DOMContentLoaded = ->
  return if Kona.isReady # Do nothing if already ready
  Kona.isReady = true
  for callback in Kona.readyCallbacks
    callback.call()

# Hook the various DOM loaded events. Borrowed from jQuery's implementation.
# TODO: CHECK FOR EVENT SUPPORT
if document.readyState != 'complete'
  if document.addEventListener
    document.addEventListener('DOMContentLoaded', Kona.DOMContentLoaded, false)
    window.addEventListener('load', Kona.DOMContentLoaded, false)

  else if document.attachEvent
    document.attachEvent('onreadystatechange', Kona.DOMContentLoaded)
    window.attachEvent('onload', Kona.DOMContentLoaded)
