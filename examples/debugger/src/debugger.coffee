# ----------------------
#   INITIALIZATION
# ----------------------
Kona.Canvas.init('canvas')



# ----------------------
#   PLAYER INIT
# ----------------------
# Add the player manually so we can have a reference object to bind keys to

#player = new Player { x: 180, y: 200, width: 55, height: 65, persistent: true }  # Blank
player = new Player { x: 30, y: 10, width: 55, height: 65, persistent: true }     # s1
# player = new Player { x: 200, y: 440, width: 55, height: 65, persistent: true } # s2


# TODO: die_left anim
Player.loadAnimations {
  'idle_right' : { sheet: 'img/player/idle_right.png', active: true }
  'idle_left'  : { sheet: 'img/player/idle_left.png' }
  'run_right'  : { sheet: 'img/player/run_right.png' }
  'run_left'   : { sheet: 'img/player/run_left.png'  }
  'fire_right' : { sheet: 'img/player/fire_right.png', next: -> @entity.resetAnimation() }
  'fire_left'  : { sheet: 'img/player/fire_left.png',  next: -> @entity.resetAnimation() }
  'die_right'  : { sheet: 'img/player/die_right.png', width: 70, height: 65, next: -> @entity.reset() }
}

Kona.Scenes.currentScene.addEntity(player)



# ----------------------
#   ENEMY INIT
# ----------------------
Strogg.loadAnimations {
  'idle_left'  : { sheet: 'img/enemies/strogg/idle_left.png'  }
  'idle_right' : { sheet: 'img/enemies/strogg/idle_right.png' }
  'run_left'   : { sheet: 'img/enemies/strogg/run_left.png'   }
  'run_right'  : { sheet: 'img/enemies/strogg/run_right.png', active: true }
}

Turtle.loadAnimations {
  'run_right' : { sheet: 'img/enemies/turtle/run_right.png', active: true }
  'run_left'  : { sheet: 'img/enemies/turtle/run_left.png' }
  'die'       : { sheet: 'img/enemies/turtle/die.png', next: -> @entity.destroy() }
}



# ----------------------
#   KEYS
# ----------------------
Kona.Keys.keydown = (key) ->
  switch key
    when 'left'  then player.setDirection('left')
    when 'right' then player.setDirection('right')
    when 'up'    then player.jump()
    when 'space' then player.fire()
    when 'esc' then Kona.togglePause()

Kona.Keys.keyup = (key) ->
  switch key
    when 'left', 'right' then player.stop('x')
    when 'up', 'down'    then player.stop('y')



#----------------------
#   LAYOUT
# ----------------------
# TODO: If scoping by map name, how to do global definitions?

Kona.Scenes.loadDefinitions [
  'level-1' : {
    '--': { entity: Kona.BlankTile }

    # Tiles
    # ---------------
    # Tops
    'tl': { entity: Kona.Tile, opts: { sprite: 'img/tiles/dirt/topl.png' } }
    'tv': { entity: Kona.Tile, opts: { sprite: 'img/tiles/dirt/topv.png' } } # Vine
    'tc': { entity: Kona.Tile, opts: { sprite: 'img/tiles/dirt/topc.png' } }
    'tr': { entity: Kona.Tile, opts: { sprite: 'img/tiles/dirt/topr.png' } }

    # Mids
    'm1': { entity: Kona.Tile, opts: { sprite: 'img/tiles/dirt/mid1.png' } }
    'm2': { entity: Kona.Tile, opts: { sprite: 'img/tiles/dirt/mid2.png' } } # Vine
    'm3': { entity: Kona.Tile, opts: { sprite: 'img/tiles/dirt/mid3.png' } }
    'm4': { entity: Kona.Tile, opts: { sprite: 'img/tiles/dirt/mid4.png' } }

    # Bases
    'b1': { entity: Kona.Tile, opts: { sprite: 'img/tiles/dirt/base1.png' } }
    'b2': { entity: Kona.Tile, opts: { sprite: 'img/tiles/dirt/base2.png' } } # Vine
    'b3': { entity: Kona.Tile, opts: { sprite: 'img/tiles/dirt/base3.png' } }
    'b4': { entity: Kona.Tile, opts: { sprite: 'img/tiles/dirt/base4.png' } }

    # Floors
    'f1': { entity: Kona.Tile, opts: { sprite: 'img/tiles/dirt/floor1.png' } }
    'f2': { entity: Kona.Tile, opts: { sprite: 'img/tiles/dirt/floor2.png' } }
    'f3': { entity: Kona.Tile, opts: { sprite: 'img/tiles/dirt/floor3.png' } }

    # Platforms
    'pl': { entity: Kona.Tile, opts: { sprite: 'img/tiles/dirt/pl.png' } }
    'p1': { entity: Kona.Tile, opts: { sprite: 'img/tiles/dirt/pc1.png' } }
    'p2': { entity: Kona.Tile, opts: { sprite: 'img/tiles/dirt/pc2.png' } }
    'pr': { entity: Kona.Tile, opts: { sprite: 'img/tiles/dirt/pr.png' } }


    # Enemies
    # ---------------
    'xs': { entity: Strogg, opts: { offset: { y: 0 }, dx: -1, sprite: 'img/enemies/strogg/idle_right.png' } }
    'xT': { entity: Turtle, opts: { sprite: 'img/enemies/turtle/idle_right.png' } }


    # Collectables
    # ---------------
    'cc': { group: 'coins',  entity: Coin,      opts: { offset: { x: 20, y: 20 }, sprite: 'img/powerups/coin.png'     } }
    'mm': { group: 'health', entity: Coffee,    opts: { offset: { x: 15, y: 15 }, sprite: 'img/powerups/mug.png'      } }
    'ee': { group: 'health', entity: Espresso,  opts: { offset: { x: 15, y: 15 }, sprite: 'img/powerups/espresso.png' } }
    'CC': { group: 'health', entity: Pill,      opts: { offset: { x: 15, y: 15 }, sprite: 'img/powerups/pill.png'     } }

    # 'pp': { entity: Pistol, opts: { offset: { x: 15, y: 15 }, sprite: 'img/weapons/pistol.png' } }
    'pp': { entity: Pistol, opts: { offset: { x: 15, y: 0 }, sprite: 'img/weapons/pistol2.png' } }
    'RR': { entity: Pistol, opts: { offset: { x: 0, y: 0 }, sprite: 'img/weapons/rifle.png'  } } # TODO
    # DOOM ARMOR: offset: { x: 2, y: 20 }


    # Triggers
    # ---------------
    'Ts': { entity: Spring, opts: { offset: { y: 31 }, sprite: 'img/spring_60_3.png' } } # TODO
    'Te': { entity: Elevator, opts: { sprite: '' } } # TODO
    # 'Tp': { entity: Sign, opts: { width: 50, height: 60, sprite: 'img/signs/sign1.png', popupOpts: { x: 30, y: 30, width: 660, height: 480, sprite: 'img/signs/hellopng' } } } # TODO
  }
]




Kona.Scenes.loadScenes [
  {
    map: 'level-1'
    background: 'img/backgrounds/lvl2.jpg'
    entities: [
      ['--','--','--','--','--','--','--','--','--','b1','--','--'],
      ['--','--','--','--','--','--','--','--','--','--','--','--'],
      ['--','--','--','--','--','--','--','--','--','--','--','--'],
      ['--','--','--','mm','--','--','--','--','cc','cc','cc','--'],
      ['tv','f2','f3','f3','--','--','f3','f2','f1','f3','f2','f1'],
      ['m2','--','--','--','--','--','--','--','--','--','--','--'],
      ['m2','--','--','--','--','--','--','--','--','--','--','--'],
      ['m2','--','--','--','tl','tr','--','--','--','--','--','--'],
      ['m2','cc','cc','tc','m1','m3','tc','tr','--','--','xT','--'],
      ['b2','f1','f2','b1','b3','b4','b1','b3','f1','f3','f2','f1']
    ]
    # entities: [
    #   ['--','--','--','--','--','--','--','--','--','--','--','--'],
    #   ['--','--','--','--','--','--','--','--','--','--','--','--'],
    #   ['--','--','--','--','--','--','--','--','--','--','--','--'],
    #   ['--','--','--','--','--','--','--','--','--','--','--','--'],
    #   ['--','--','--','--','--','--','--','--','--','--','--','--'],
    #   ['--','--','--','--','--','--','--','--','--','--','--','--'],
    #   ['--','--','--','--','--','--','--','--','--','--','--','--'],
    #   ['--','--','--','--','--','--','--','--','--','--','--','--'],
    #   ['--','--','--','--','--','--','--','--','--','--','--','--'],
    #   ['b2','f1','f2','b1','b3','b4','b1','b3','f1','f3','f2','f1']
    # ]
  },

  {
    map: 'level-1'
    background: 'img/backgrounds/lvl2.jpg'
    entities: [
      ['--','--','--','--','--','--','--','--','--','m2','--','--'],
      ['--','--','--','--','--','--','--','--','--','m2','--','--'],
      ['--','--','--','--','--','--','xs','cc','cc','m1','--','--'],
      ['tc','tr','--','--','--','--','tr','tc','tc','m3','--','tl'],
      ['--','--','--','--','--','--','--','--','--','m4','--','m3'],
      ['--','--','--','--','--','--','--','--','--','b1','--','m4'],
      ['--','--','--','--','--','Ts','--','--','--','--','--','m3'],
      ['--','pp','--','xT','tl','tc','tr','--','--','--','--','m1'],
      ['f1','f3','f2','f1','b4','b3','b1','f3','f1','f3','b1','b4']
    ]
  }

  {
    map: 'level-1'
    background: 'img/backgrounds/lvl2.jpg'
    entities: [
      ['--','--','--','--','--','--','--','--','--','--','--','--'],
      ['--','--','--','--','--','--','--','--','--','--','--','--'],
      ['--','--','--','--','--','--','--','--','--','--','--','pl'],
      ['p1','p2','pr','--','--','--','--','--','pl','pr','--','--'],
      ['--','--','--','--','--','xs','cc','--','--','--','--','--'],
      ['--','--','--','--','pl','p1','pr','--','--','xT','mm','--'],
      ['--','--','--','--','--','--','--','--','pl','p2','pr','--'],
      ['--','--','--','--','--','--','--','--','--','--','--','--'],
      ['--','--','--','--','--','--','--','--','--','--','--','--'],
    ]
  }
]


# Have to add signs manually so we can specify backgrounds
# Kona.Scenes.find("s1").addEnt


# Have to add elevators manually so we can specify a maximum height
Kona.Scenes.find("s2").addEntity(new Elevator(width: 60, height: 60, x: 600, y: 480, maxHeight: 180, sprite: 'img/plate_4.png'))



# ----------------------
#   HUD
# ----------------------



# ----------------------
#   GAME START
# ----------------------
Kona.Events.on "s1_activate", ->
  puts "s1 activated"
#   setTimeout ->
#     puts "spawning turtle"
#     Kona.Sounds.play("audio/spawn.wav", { autoplay: true }) # TODO: if given path, should probably default autoplay
#     Kona.Scenes.currentScene.addEntity(new Turtle { x: 350, y: 0, dx: 1 })
#   , _.random(500, 1000)


Kona.Events.on "s2_activate", -> puts "s2 activated"



Kona.Engine.start()

# Kona.Sounds.play('audio/music/revolution.mp3', { autoplay: true, loop: true, volume: 20 })


# TEST SCENE 2
# -----------------------
# Kona.Scenes.setCurrent("s2")
# Kona.Scenes.currentScene.addEntity(player)


# TEST SCENE 3
# -----------------------
# Kona.Scenes.setCurrent("s3")
# Kona.Scenes.currentScene.addEntity(player)


# SPAWN COINS
# -----------------------
# setInterval ->
#   Kona.Scenes.currentScene.addEntity(new Coin({
#     group: 'coins', x: _.random(Kona.Canvas.width), y: _.random(0, Kona.Canvas.height),
#     offset: { x: 20, y: 20 }, sprite: 'img/powerups/coin.png'
#   }))
# , 300


# QuadTree shortcuts
# window.s = Kona.Scenes.currentScene
# window.t = s.tree
# window.r = t.root
# window.p = s.entities.get('player')[0]
