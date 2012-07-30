Kona.ready ->
  Kona.debug 'ready'

  Kona.Keys.bind "left", ->
    console.log "you pressed left!"


  menu = new Kona.Scene {
    name: 'menu-1'
    background: 'lvl1.jpg'
    active: true
  }

  level = new Kona.Scene {
    name: 'level-1'
    background: 'lvl2.jpg'
  }

  Kona.Engine.start {
    id: 'canvas'
  }

  setTimeout ->
    Kona.Scenes.setCurrent 'level-1'
  , 2000
