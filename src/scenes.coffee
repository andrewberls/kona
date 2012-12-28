# A scene represents a distinct game state, such as a menu or a level screen.
#
# Entities are added to a particular scene using a grid-like layout,
# which corresponds to a definition map.
#
# The engine will take care of rendering the current scene, including
# updating and drawing its associated entities, although scene
# transitions must be specified manually.

Kona.Scenes =
  scenes: []
  currentScene: {}
  definitionMap: null

  drawCurrent: ->
    @currentScene.draw()


  # Find the new scene by name and set it to active to start rendering
  # Ex: `Kona.Scenes.setCurrent('lvl1:s2')`
  setCurrent: (sceneName) ->
    @currentScene.active = false
    newScene = Kona.Utils.find(@scenes, { name: sceneName }) or throw new Error("Couldn't find scene: #{sceneName}")
    @currentScene = newScene
    @currentScene.active = true


  # Advance to the next scene for a level, assuming the names conforms to the format
  # lvl<levelNum>:s<sceneNum>
  # Ex: Level 1, Scene 2 -> 'lvl1:s2'
  nextScene: ->
    [levelId, sceneId] = @currentScene.name.split(':')
    sceneNum = parseInt(sceneId.replace('s', '')) + 1
    @setCurrent("#{levelId}:s#{sceneNum}")

  # Advance to the first scene of the next level, assuming the names conform to the format
  # lvl<levelNum>:s<sceneNum>
  # Ex: Level 1, Scene 2 -> 'lvl1:s2'
  nextLevel: ->
    [levelId, sceneId] = @currentScene.name.split(':')
    levelNum = parseInt(levelId.replace('lvl', '')) + 1
    @setCurrent("lvl#{levelNum}:s1")



class Kona.Scene
  constructor: (options={}) ->
    @active         = options.active || false
    @name           = options.name   || throw new Error("Scene must have a name")
    @background     = new Image()
    @background.src = options.background || ''
    @entities       = {}
    Kona.Scenes.scenes.push(@)


  # Add a single entity to a named group
  addEntity: (entity) ->
    group = entity.group
    @entities[group] ||= []
    @entities[group].push(entity)


  # Initialize and construct the associated entities for a scene
  #
  # * __grid__: (Array) - A two dimensional array ('grid') of values to load into the scene.
  #   All values must correspond to rules in the definition map, explained previously,

  # An example building the first screen of the first level (assuming a scene object has
  # already been instantiated):
  #
  #     level1_1.loadEntities [
  #       ['-','-','-','-','-',],
  #       ['r','b','-','-','-',],
  #       ['o','-','-','-','-',],
  #       ['r','-','c','-','-',],
  #       ['b','o','r','b','r',]
  #     ]
  loadEntities: (grid) ->
    Kona.Scenes.definitionMap? or fail("No definition map found")
    x = 0
    y = Kona.Canvas.height - (grid.length * Kona.Tile.tileSize)

    for row in grid
      for def in row
        rule   = Kona.Scenes.definitionMap[def] or fail("No mapping found for rule: #{def}")

        offset = if rule.opts then rule.opts.offset else {}
        startX = if offset? then x + (offset.x || 0) else x
        startY = if offset? then y + (offset.y || 0) else y

        opts  = Kona.Utils.merge { x: startX, y: startY, group: rule.group  }, rule.opts
        obj   = new rule.klass(opts)
        @addEntity(obj)
        x += Kona.Tile.tileSize

      x = 0
      y += Kona.Tile.tileSize


  # Remove an entity from a named group. Prefer `entity.destroy()` instead of calling this directly.
  removeEntity: (group, entity) ->
    list = @entities[group]
    for ent, idx in list
      list.splice(idx, 1) if entity == ent


  # Render a scene and all of its entities onto the main canvas
  #
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
