# The engine is responsible for starting and running the main game loop.

Kona.Engine =

  # FPS default only used for requestAnimFrame fallback
  defaults:
    fps:    24
    width:  660
    height: 480

  running: false

  # Internal queue of callbacks to invoke once the engine starts
  _queue: []


  # Add a function to the startup queue
  #
  # Ex:
  #
  #     Kona.Engine.queue =>
  #       console.log "Engine is running now!"
  #
  queue: (fn) ->
    if @running then fn() else @_queue.push(fn)


  # Set the initial scene (specified as active), and kick off
  # the animation loop. To be invoked after all other necessary game setup.
  #
  # Ex: `Kona.Engine.start()`
  #
  start: (opts={}) ->
    @fps     = opts.fps || @defaults.fps
    Kona.Scenes.currentScene = Kona.Scenes.scenes[0]
    Kona.Scenes.currentScene? or fail("Engine#start", "No scenes found")
    @running = true
    fn() for fn in @_queue
    @run()


  # Repeatedly draw the current scene by requesting animation frames
  run: ->
    requestAnimFrame(Kona.Engine.run, Kona.Canvas.elem)
    Kona.Scenes.drawCurrent()



# [requestAnimationShim by Paul Irish](http://paulirish.com/2011/requestanimationframe-for-smart-animating/)
window.requestAnimFrame = do ->
  return  window.requestAnimationFrame       ||
          window.webkitRequestAnimationFrame ||
          window.mozRequestAnimationFrame    ||
          window.oRequestAnimationFrame      ||
          window.msRequestAnimationFrame     ||
          (callback) ->
            # setTimeout fallback for unsupported browsers
            setTimeout(callback, 1000 / Kona.Engine.defaults.fps)
