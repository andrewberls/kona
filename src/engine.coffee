# Handles game clock, main update/draw loop

Kona.Engine = {}

Kona.Engine.defaults =
  fps: 24 # Only used for requestAnimationFrame fallback
  width: 640
  height: 480

Kona.Engine.start = (canvas, fps) ->
  Kona.debug 'starting'
  @fps =  fps || @defaults.fps

  # TODO: Do these belong in a Graphics namespace or similar?
  @canvas   = document.getElementById(canvas.id)
  @ctx      = @canvas.getContext('2d')
  @C_WIDTH  = canvas.width  || @defaults.width
  @C_HEIGHT = canvas.height || @defaults.height

  @run()

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
