Kona.ready ->
  Kona.debug 'ready'

  Kona.Keys.bind "left", ->
    console.log "you pressed left!"


  menu = new Kona.Scene {
    name: 'menu-1',
    background: 'lvl1.jpg',
    active: true
  }

  Kona.Engine.start {
    id: 'canvas'
  }
