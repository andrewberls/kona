# Handles game clock, update/draw, buffer rendering

Kona.Engine = {}

Kona.Engine._defaultFPS = 24

Kona.Engine.start = (fps) ->
  Kona.debug 'start'
  Kona.Engine._fps =  fps || Kona.Engine._defaultFPS
  Kona.Engine.run()

Kona.Engine.run = ->
  Kona.debug 'running'
  Kona.Engine.update()
  Kona.Engine.draw()
  requestAnimFrame(Kona.Engine.run)

Kona.Engine.update = ->
  # Update all entities

Kona.Engine.draw = ->
  # Draw all entities
  # TODO: how to split up rendering to back buffer vs main canvas?

# Kona.Engine.stop = ->


window.requestAnimFrame = do ->
  return  window.requestAnimationFrame       ||
          window.webkitRequestAnimationFrame ||
          window.mozRequestAnimationFrame    ||
          window.oRequestAnimationFrame      ||
          window.msRequestAnimationFrame     ||
          (callback) ->
            # setTimeout fallback for unsupported browsers
            Kona.Engine._timeoutId = setTimeout(callback, 1000 / Kona.Engine._fps)
