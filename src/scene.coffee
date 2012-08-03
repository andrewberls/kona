# A scene represents a distinct game state, such as a menu or a level.
# Entities are added to a particular scene and defined in a layout.
# The engine takes care of rendering the current scene, although
# transitions must be specified manually.


Kona.Scenes =
  _scenes: []

  currentScene: {}

  drawCurrent: ->
    @currentScene.draw()

  setCurrent: (sceneName) ->
    # Find the new scene by name and set it to active to start rendering
    # ex: Kona.Scenes.setCurrent('level-2')
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

  setLayout: (schema) ->
    # TODO: definition schema here is ugly
    #
    # [                                 Schema
    #   {                                 Object Definition
    #     entity: Player,
    #     layout: [ {opts}, {opts} ]        Options
    #   }
    # ]

    for definition in schema
      entity = definition.entity
      for opts in definition.layout
        @addEntity(new entity(opts))




  update: ->

  draw: ->
    # Render onto main canvas
    # Kona.debug "will draw: #{@name}"
    Kona.Engine.ctx.drawImage(@background, 0, 0)
    # for entity in @entities
    #   entity.draw()
