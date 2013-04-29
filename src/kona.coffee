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

Kona.readyQueue = []
Kona.isReady    = false

# Pause logic
# If gamePaused is set to true, the current scene will draw but not update
# freezing things until gameplay resumes
Kona.gamePaused = false

Kona.togglePause = ->
  # TODO: where to dismiss sign backgrounds?
  # Can't put it here - signs are not core
  # for ent in Kona.Scenes.currentScene.getEntities('sign_backgrounds')
  #   ent.destroy()
  @gamePaused = !@gamePaused
  if @gamePaused
    Kona.Events.trigger('onPause')
  else
    Kona.Events.trigger('onResume')


Kona.onPause  = (fn) -> Kona.Events.bind('onPause', fn)
Kona.onResume = (fn) -> Kona.Events.bind('onResume', fn)


# Invoke a callback function when the document has fully loaded. Can be invoked
# multiple times - callbacks will be pushed onto a list
#
# Ex:
#
#     Kona.ready ->
#       console.log "Ready to go!"
#
Kona.ready = (callback) ->
  if document.readyState == 'complete'
    Kona.isReady = true

  # If the DOM is already ready, just invoke the callback.
  if Kona.isReady
    callback.call()
  else
    Kona.readyQueue.push(callback)


# Internal function hooked to the DOM's ready event. Do nothing if already ready
Kona.DOMContentLoaded = ->
  return if Kona.isReady
  Kona.isReady = true
  for callback in Kona.readyQueue
    callback.call()



# Hook the various DOM loaded events. Borrowed from jQuery's implementation.
if document.readyState != 'complete'
  if document.addEventListener
    document.addEventListener('DOMContentLoaded', Kona.DOMContentLoaded, false)
    window.addEventListener('load', Kona.DOMContentLoaded, false)

  else if document.attachEvent
    document.attachEvent('onreadystatechange', Kona.DOMContentLoaded)
    window.attachEvent('onload', Kona.DOMContentLoaded)
