#    _  __                                _
#   | |/ /   ___    _ __     __ _        (_)  ___
#   | ' /   / _ \  | '_ \   / _` |       | | / __|
#   | . \  | (_) | | | | | | (_| |  _    | | \__ \
#   |_|\_\  \___/  |_| |_|  \__,_| (_)  _/ | |___/
#                                      |__/
#
#
#   https://github.com/andrewberls/kona
#
#
# Set the main object on the window
window.Kona = {}

# Internals for `Kona.ready()`
Kona.readyQueue = []
Kona.isReady    = false


# Pause logic

# If gamePaused is set to true, the current scene will draw but not update
# freezing things until gameplay resumes
Kona.gamePaused = false


# Public: Toggle the pause state, e.g., unpaused -> paused or vice versa
# Triggers a corresponding event, either onPause or onResume
#
# Ex: Kona.togglePause()
#
# Returns nothing
#
Kona.togglePause = ->
  @gamePaused = !@gamePaused
  event = if @gamePaused then 'Pause' else 'Resume'
  Kona.Events.trigger("on#{event}")


# Public: Bind a function to the game pause event
#
# Ex: `Kona.onPause -> console.log("Game was paused!")`
#
# Returns nothing
#
Kona.onPause  = (fn) -> Kona.Events.bind('onPause', fn)


# Public: Bind a function to the game resume (unpause) event
#
# Ex: `Kona.onResume -> console.log("Game was resumed!")`
#
# Returns nothing
#
Kona.onResume = (fn) -> Kona.Events.bind('onResume', fn)



# Public: Invoke a callback function when the document has fully loaded. Can be invoked
# multiple times - callbacks will be pushed onto a list
#
# callback - Function to call when loading is finished
#
# Ex:
#
#     Kona.ready ->
#       console.log "Ready to go!"
#
# Returns nothing
#
Kona.ready = (callback) ->
  if document.readyState == 'complete'
    Kona.isReady = true

  # If the DOM is already ready, just invoke the callback.
  if Kona.isReady
    callback.call()
  else
    Kona.readyQueue.push(callback)


# Internal: function hooked to the DOM's ready event. Do nothing if already ready
Kona.DOMContentLoaded = ->
  return if Kona.isReady
  Kona.isReady = true
  for callback in Kona.readyQueue
    callback.call()



# Internal: Hook the various DOM loaded events. Borrowed from jQuery's implementation.
if document.readyState != 'complete'
  if document.addEventListener
    document.addEventListener('DOMContentLoaded', Kona.DOMContentLoaded, false)
    window.addEventListener('load', Kona.DOMContentLoaded, false)

  else if document.attachEvent
    document.attachEvent('onreadystatechange', Kona.DOMContentLoaded)
    window.attachEvent('onload', Kona.DOMContentLoaded)
