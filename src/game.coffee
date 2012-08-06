# Sample code for a 'game', to test the various engine functions
# in a more real environment. Kept in a single file for manageability
# during development - no point in splitting things up here.


Kona.ready ->
  # Are we actually ready?
  Kona.debug 'ready'



  # Test a random key binding
  Kona.Keys.bind "a", ->
    console.log "you pressed a!"



  # The 'menu', or first scene that the player will see.
  menu = new Kona.Scene {
    name: 'menu-1'
    background: 'lvl1.jpg'
    active: true
  }







  # Define a scene and load some entities
  level = new Kona.Scene {
    name: 'level-1'
    background: 'lvl2.jpg',
  }

  # TODO: how to bind methods on entities defined with the schema loader?
  # Maybe schema loader is only for things like blocks, etc?

  # level.setLayout [
  #   {
  #     entity: Ball,
  #     layout: [
  #       {x: 10, y:20, width: 75, height: 50},
  #       {x: 75, y: 100, width: 75, height: 50}
  #     ]
  #   }
  # ]






  # A sample game entity to test rendering and schema loading
  class Shape extends Kona.Entity
    constructor: (opts) ->
      @position =
        x: opts.x || 0
        y: opts.y || 0

      @direction =
        dx: opts.dx || 0
        dy: opts.dy || 0

      @box =
        width: opts.width   || 0
        height: opts.height || 0

      @sprite = new Image() # TODO: Kona.Sprite /sheet ?
      @sprite.src = ''

      super # TODO

    update: ->
      # TODO
      @position.x += @direction.dx
      @position.y += @direction.dy

    draw: ->
      #Kona.Engine.ctx.drawImage(@sprite, @position.x, @position.y)
      Kona.Engine.ctx.fillRect(@position.x, @position.y, @box.width, @box.height)




  shape = new Shape({ x: 400, y: 20, width: 75, height: 50 })
  level.addEntity(shape)









  # Start the engine! The game is running after this point.
  Kona.Engine.start {
    id: 'canvas'
  }



  # Test transitions between scenes after a fixed time period
  setTimeout ->
    Kona.Scenes.setCurrent 'level-1'
  , 500
