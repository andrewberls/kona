# Handles game clock, main update/draw loop

Kona.Engine = {}

Kona.Engine.defaults =
  fps: 24 # Only used for requestAnimationFrame fallback
  width: 640
  height: 480

Kona.Engine.start = (canvas, fps) ->
  Kona.debug 'starting'
  Kona.Engine.fps =  fps || Kona.Engine.defaults.fps

  # TODO: Do these belong in a Graphics namespace or similar?
  Kona.Engine.canvas   = document.getElementById(canvas.id)
  Kona.Engine.ctx      = Kona.Engine.canvas.getContext('2d')
  Kona.Engine.C_WIDTH  = canvas.width  || Kona.Engine.defaults.width
  Kona.Engine.C_HEIGHT = canvas.height || Kona.Engine.defaults.height

  Kona.Engine.run()

Kona.Engine.run = ->
  # Kona.debug 'running'
  # TODO: engine update/draw or just call on current scene?
  Kona.Engine.update()
  Kona.Engine.draw()
  requestAnimFrame(Kona.Engine.run)

Kona.Engine.update = ->
  # Update all entities

Kona.Engine.draw = ->
  # Draw current scene onto main canvas


window.requestAnimFrame = do ->
  return  window.requestAnimationFrame       ||
          window.webkitRequestAnimationFrame ||
          window.mozRequestAnimationFrame    ||
          window.oRequestAnimationFrame      ||
          window.msRequestAnimationFrame     ||
          (callback) ->
            # setTimeout fallback for unsupported browsers
            setTimeout(callback, 1000 / Kona.Engine.defaults.fps)
