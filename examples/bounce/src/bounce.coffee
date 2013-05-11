# Wrap everything in Kona.ready callback
# to run when the browser finishes loading
Kona.ready ->

  # Initialize the main canvas with the id of our `<canvas>` element
  Kona.Canvas.init('gameCanvas')


  # This example has just one scene, which will start rendering
  # as soon as the engine starts
  main = new Kona.Scene { name: 'main', active: true }



  # Our main shape that will be bouncing around the screen
  # All distinct entities on the screen should inherit from `Kona.Entity`
  class Shape extends Kona.Entity
    # Our constructor mostly just passes things through to the main
    # Entity constructor, but we explicitly turn off gravity for this object
    # Setting the group here prevents us from having to specify it when we construct
    # instances of this class
    @group = 'shapes'

    constructor: (opts={}) ->
      super(opts)
      @gravity = false


    # `update()` is responsible for changing the object's state
    # (position, direction, etc) as necessary.
    update: ->
      super()

      # Reverse direction if we hit a wall on any side
      @direction.dx *= -1 if @left() <= 0 || @right()  >= Kona.Canvas.width
      @direction.dy *= -1 if @top()  <= 0 || @bottom() >= Kona.Canvas.height


    # `draw()` is responsible for rendering the object to the screen
    # Here, we draw a simple rectangle using Kona's `drawRect` method
    # which is just an easier way of calling `canvas.ctx.fillRect()`
    draw: ->
      Kona.Canvas.safe =>
        Kona.Canvas.drawRect(@position, @box, color: 'blue')



  # Construct a shape object with some initial direction/speed and
  # add it to the scene
  square = new Shape { x: 200, y: 200, width: 20, height: 20, dx: -2, dy: -1, speed: 3 }
  main.addEntity(square)


  # At this point, we're ready to start the engine!
  Kona.Engine.start()
