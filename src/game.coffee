Kona.ready ->
  Kona.debug 'ready'
  Kona.Engine.start {
    id: 'canvas'
  }
  Kona.Keys.bind "a", ->
    console.log "You pressed a!"

  Kona.Keys.bind "left", ->
    console.log "you pressed left!"
