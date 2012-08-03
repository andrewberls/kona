# Sample code for a 'game', to test the various engine functions
# in a more real environment. Kept in a single file for manageability
# during development - no point in splitting things up here.


Kona.ready ->
  # Are we actually ready?
  Kona.debug 'ready'



  # Test a random key binding
  Kona.Keys.bind "left", ->
    console.log "you pressed left!"



  # The 'menu', or first scene that the player will see.
  menu = new Kona.Scene {
    name: 'menu-1'
    background: 'lvl1.jpg'
    active: true
  }



  # A sample game entity to test rendering and schema loading
  class Player extends Kona.Entity
    constructor: (opts) ->
      Kona.debug "\nMaking a player!"
      Kona.Utils.inspect opts, 'player opts'



  # Define a scene and load some entities
  level = new Kona.Scene {
    name: 'level-1'
    background: 'lvl2.jpg',
  }

  level.setLayout [
    {
      entity: Player,
      layout: [
        {x: 10, y:20},
        {x: 75, y: 100}
      ]
    }
  ]



  # Start the engine! The game is running after this point.
  Kona.Engine.start {
    id: 'canvas'
  }



  # Test transitions between scenes after a fixed time period
  setTimeout ->
    Kona.Scenes.setCurrent 'level-1'
  , 2000
