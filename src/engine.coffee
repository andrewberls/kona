# Handles game clock, main update/draw loop

Kona.Engine =
  defaults:
    fps:    24 # Only used for requestAnimationFrame fallback
    width:  640
    height: 480

  start: (opts) ->
    # Kona.Canvas.init(opts.id)
    @fps = opts.fps || @defaults.fps
    Kona.Scenes.currentScene = Kona.Utils.findByKey(Kona.Scenes._scenes, 'active', true)
    @run()

  run: ->
    # Get animation frames to draw the current scene onto main canvas
    Kona.Scenes.drawCurrent()
    requestAnimFrame(Kona.Engine.run)


window.requestAnimFrame = do ->
  return  window.requestAnimationFrame       ||
          window.webkitRequestAnimationFrame ||
          window.mozRequestAnimationFrame    ||
          window.oRequestAnimationFrame      ||
          window.msRequestAnimationFrame     ||
          (callback) ->
            # setTimeout fallback for unsupported browsers
            setTimeout(callback, 1000 / Kona.Engine.defaults.fps)
