# A scene represents a distinct game state, such as a menu or a level screen.
#
# Entities are added to a particular scene using a grid-like layout,
# which corresponds to a definition map.
#
# The engine will take care of rendering the current scene, including
# updating and drawing its associated entities, although scene
# transitions must be specified manually.

Kona.Scenes =

  # Internal list of definition maps, keyed by title
  maps: []

  # Internal list of scenes
  scenes: []

  # The scene that is currently drawing to the canvas
  # If addEntity() is called on a scene before the engine starts, push new entity onto the queue
  currentScene: {
    addEntity: (ent) ->
      Kona.Engine.queue -> Kona.Scenes.currentScene.addEntity(ent)
  }

  # Parse and save a list of definition maps.
  # Ex defns format: `[ { name1 : map1 }, { name2 : map2 } ]`
  loadDefinitions: (defns) ->
    for def in defns
      for name, map of def
        @maps.push { name: name, map: map }


  # Initialize scenes in order from a list of arguments
  loadScenes: (argList=[]) ->
    sceneNum = 1
    for args in argList
      scene = new Kona.Scene(Kona.Utils.merge { name: "s#{sceneNum}" }, args)
      sceneNum++

    @currentScene = @scenes[0]


  drawCurrent: -> @currentScene.draw()


  # Find the new scene by name and set it to active to start rendering
  # Ex: `Kona.Scenes.setCurrent('lvl1:s2')`
  setCurrent: (sceneName) ->
    @currentScene.active = false
    newScene = Kona.Utils.find(@scenes, { name: sceneName }) or fail("Couldn't find scene: #{sceneName}")
    @currentScene = newScene
    @currentScene.active = true


  # Advance to the next scene, in the order specified in the scene initialization
  nextScene: ->
    sceneNum = parseInt @currentScene.name.replace('s', '')
    @setCurrent("s#{++sceneNum}")



# Construct a single scene instance
# Prefer `Kona.Scenes.loadScenes()` instead of calling this directly
#
#     class Enemy extends Kona.Entity
#       constructor: (opts={}) ->
#         super(opts)
#         @isEvil = true
#
# Constructor options:
#
#   * __map__ - (String) The name of the corresponding definition map. Ex: `level-1`
#   * __name (Required)__ - (String) The name of the scene. Ex: `lvl1:s2`
#   * __active__ - (Boolean) Whether or not this scene is actively being drawn to the screen
#   * __background__ - (String) The path to a background image. Ex: `img/jungle.png`
#   * __entities__ - (Array) A 2D grid specifying the scene's entity layout, using
#      defintions from a map (specified in `map`)
#
class Kona.Scene
  constructor: (opts={}) ->
    @map            = opts.map
    @name           = opts.name or fail("Scene must have a name")
    @active         = if opts.active? then opts.active else false
    @background     = new Image()
    @background.src = opts.background || ''
    @entities       = {}
    @loadEntities(opts.entities) if opts.entities?
    Kona.Scenes.scenes.push(@)


  # Add a single entity to a named group
  addEntity: (entity) ->
    group = entity.group
    @entities[group] ||= []
    @entities[group].push(entity)


  # Initialize and construct the associated entities for a scene
  #
  # Parameters:
  #
  #   * __grid__: (Array) - A two dimensional array ('grid') of values to load into the scene.
  #     All values must correspond to rules in the definition map, explained previously,
  #
  # An example might look like:
  #
  #     [
  #       ['-','-','-','-','-',],
  #       ['r','b','-','-','-',],
  #       ['o','-','-','-','-',],
  #       ['r','-','c','-','-',],
  #       ['b','o','r','b','r',]
  #     ]
  #
  loadEntities: (grid) ->
    x   = 0
    y   = Kona.Canvas.height - (grid.length * Kona.Tile.tileSize)
    map = Kona.Utils.find(Kona.Scenes.maps, { name: @map }).map

    for row in grid
      for def in row
        rule   = map[def] or fail("No mapping found for rule: #{def}")
        offset = if rule.opts then rule.opts.offset else null
        startX = if offset? then x + (offset.x || 0) else x
        startY = if offset? then y + (offset.y || 0) else y
        opts   = Kona.Utils.merge { x: startX, y: startY, group: rule.group  }, rule.opts
        obj    = new rule.entity(opts)
        @addEntity(obj)
        x += Kona.Tile.tileSize

      x = 0
      y += Kona.Tile.tileSize


  # Remove an entity from its group. Prefer `entity.destroy()` instead of calling this directly.
  removeEntity: (entity) ->
    list = @entities[entity.group]
    for ent, idx in list
      list.splice(idx, 1) if entity == ent


  # Render a scene and all of its entities onto the main canvas
  # The drawing of a scene is split into two parts - updating and rendering.
  #
  # `update()` sets up the visual state of the entity before it is rendered to the screen -
  # this is where an entities position, direction, state etc should be assigned or modified.
  #
  # `draw()`  will then render the entities's visual state to the screen.
  #
  # See Kona.Entity
  #
  draw: ->
    Kona.Canvas.clear()
    Kona.Canvas.ctx.drawImage(@background, 0, 0) # Background
    for name, list of @entities
      for entity in list
        if entity?
          entity.update()
          entity.draw()
