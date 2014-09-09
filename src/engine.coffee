# The engine is responsible for starting and running the main game loop.


Kona.Engine =

  # Only used for requestAnimFrame fallback
  defaultFPS: 24

  running: false
  stopped: false

  # Internal: Queue of callbacks to invoke once the engine starts
  _queue: []


  # Public: Add a function to the startup queue
  #
  # fn - Function to be executed on ready
  #      Called immediately if already running, else called when engine is started
  #
  # Ex:
  #
  #     Kona.Engine.queue =>
  #       console.log "Engine is running now!"
  #
  # Returns nothing
  #
  queue: (fn) ->
    if @running then fn() else @_queue.push(fn)


  # Internal: Call and remove every function from the queue
  # Invoked on engine start
  #
  # Returns nothing
  #
  flushQueue: ->
    fn() while fn = @_queue.shift()


  # Public: Set the initial scene (specified as active), and kick off
  # the animation loop. To be invoked after all other necessary game setup.
  #
  # opts  -  Hash of Engine options
  #   fps -  Integer number of frames per second (Default: 24)
  #
  # Ex: `Kona.Engine.start()`
  #
  # Returns nothing
  #
  start: (opts={}) ->
    @fps     = opts.fps || @defaultFPS
    scene = Kona.Utils.find(Kona.Scenes.scenes, { active: true }) || Kona.Scenes.scenes[0]
    Kona.Scenes.currentScene = scene or fail("Engine#start", "No scenes found")
    @running = true
    @flushQueue()
    Kona.Scenes.currentScene.triggerActivation()
    @run()


  # Internal: Repeatedly draw the current scene by requesting animation frames
  run: ->
    return if @stopped
    requestAnimFrame(Kona.Engine.run.bind(Kona.Engine), Kona.Canvas.elem)
    Kona.Scenes.drawCurrent()


  stop: ->
    @stopped = true



# requestAnimationShim by Paul Irish
# http://paulirish.com/2011/requestanimationframe-for-smart-animating/
window.requestAnimFrame = do ->
  return  window.requestAnimationFrame       ||
          window.webkitRequestAnimationFrame ||
          window.mozRequestAnimationFrame    ||
          window.oRequestAnimationFrame      ||
          window.msRequestAnimationFrame     ||
          (callback) ->
            # setTimeout fallback for unsupported browsers
            setTimeout(callback, 1000 / Kona.Engine.defaults.fps)
