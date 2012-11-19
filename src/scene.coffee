# A scene represents a distinct game state, such as a menu or a level.
# Entities are added to a particular scene and defined in a layout.
# The engine takes care of rendering the current scene, although
# transitions must be specified manually.


Kona.Scenes =
  _scenes: []

  currentScene: {}

  drawCurrent: ->
    @currentScene.draw()

  # Find the new scene by name and set it to active to start rendering
  # Ex: Kona.Scenes.setCurrent('level-2')
  setCurrent: (sceneName) ->
    @currentScene.active = false
    @currentScene = Kona.Utils.findByKey(@_scenes, 'name', sceneName)
    @currentScene.active = true



class Kona.Scene
  constructor: (options={}) ->
    @active         = options.active || false
    @name           = options.name   || throw new Error("scene must have a name")
    @background     = new Image()
    @background.src = options.background || ''
    @entities       = []

    Kona.Scenes._scenes.push(@)

  addEntity: (entity) ->
    @entities.push(entity)

  # TODO: definition schema here is ugly
  #
  # [                                 Schema
  #   {                                 Object Definition
  #     entity: Player,
  #     layout: [ {opts}, {opts} ]        Options
  #   }
  # ]
  # setLayout: (schema) ->
  #   for definition in schema
  #     entity = definition.entity
  #     for opts in definition.layout
  #       @addEntity(new entity(opts))


  update: ->


  # Render onto main canvas
  draw: ->
    Kona.Canvas.clear()
    Kona.Canvas.ctx.drawImage(@background, 0, 0) # Background
    Kona.TileManager.draw(@name)                 # Tiles
    for entity in @entities                      # Game entities
      entity.update()
      entity.draw()
