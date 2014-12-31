tracerColors = [
  '#1B184F',
  '#312c91',
  '#423ac0',

  '#9c4274'
]


class Tracer extends Kona.Entity
  @group = 'tracers'

  constructor: (opts={}) ->
    super(opts)
    @gravity = false

    @box = {
      width: 10,
      height: 10
    }

    @color = Kona.Utils.sample(tracerColors)

    # Survive for some number of collisions before disappearing
    @lifetime = 3

    @pixels    = []
    @pixelSize = 2
    @pixelColor = '#b8b8b8'

    @pushFlag   = 0
    @pushLimit  = 5

    @sweepFlag  = 0
    @sweepLimit = 7


  drawPixels: ->
    for pixel in @pixels
      Kona.Canvas.safe =>
        Kona.Canvas.ctx.fillStyle = @pixelColor
        Kona.Canvas.ctx.fillRect(pixel.x,pixel.y,@pixelSize,@pixelSize)


  update: ->
    super()

    # Reverse direction if we hit a wall on any side
    if @left() <= 0 || @right()  >= Kona.Canvas.width
      @lifetime -= 1
      @direction.dx *= -1

    if @top()  <= 0 || @bottom() >= Kona.Canvas.height
      @lifetime -= 1
      @direction.dy *= -1

    @drawPixels()

    if @pushFlag == 0
      @pixels.push { x: @midx(), y: @midy() }

    if @sweepFlag == 0
      @pixels.shift()

    @pushFlag  = cycle(@pushFlag, @pushLimit)
    @sweepFlag = cycle(@sweepFlag, @sweepLimit)

    if @lifetime == 0
      Kona.Scenes.currentScene.removeEntity(@)


  draw: ->
    Kona.Canvas.safe => Kona.Canvas.drawRect(@position, @box, color: @color)



# Increment a number, cycling to 0 if it exceeds `limit`
cycle = (num, limit) ->
  if num > limit then 0 else num+1


# Choose a random nonzero value for dx or dy
randomMotion = ->
  res = Kona.Utils.random(-2,2)
  if res == 0 then randomMotion() else res


# Choose a random speed value
randomSpeed = ->
  Kona.Utils.sample(Kona._.range(0.5,1,0.1))


# Choose a random point on the canvas
randomX = -> Kona.Utils.random(0, Kona.Canvas.width)
randomY = -> Kona.Utils.random(0, Kona.Canvas.height)


# Add a Tracer entity to the canvas
addTracer = (opts) ->
  tracer = new Tracer(opts)
  Kona.Scenes.currentScene.addEntity(tracer)



Kona.ready ->
  Kona.Canvas.init('gameCanvas')
  main = new Kona.Scene { name: 'main', active: true }

  addTracer { x: 200, y: 200, dx: -2, dy: -1, speed: 0.75 }

  setInterval ->
    addTracer {
      x: randomX()
      y: randomY()
      dx: randomMotion()
      dy: randomMotion()
      speed: randomSpeed()
    }
  , 3000

  Kona.Engine.start()
