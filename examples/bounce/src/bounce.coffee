Kona.ready ->

  Kona.Canvas.init('canvas')

  main = new Kona.Scene { name: 'main', active: true }

  class Shape extends Kona.Entity
    update: ->
      @position.x += (@speed * @direction.dx)
      @position.y += (@speed * @direction.dy)

      @direction.dx *= -1 if @left() < 0 || @right() > Kona.Canvas.width
      @direction.dy *= -1 if @top()  < 0 || @bottom() > Kona.Canvas.height

    draw: ->
      Kona.Canvas.safe =>
        Kona.Canvas.ctx.fillStyle = 'blue'
        Kona.Canvas.ctx.fillRect(@position.x, @position.y, @box.width, @box.height)

  main.addEntity(new Shape { x: 200, y: 200, width: 20, height: 20, dx: -2, dy: -1, speed: 3, group: 'ball' })

  Kona.Engine.start()
