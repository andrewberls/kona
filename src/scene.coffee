# A scene represents a distinct game state, such as a menu or a level.
# Entities are added to a particular scene, and the engine takes care of
# rendering the current scene.


Kona.Scenes = {}

Kona.Scenes.scenes = [] # TODO: better naming
Kona.Scenes.currentScene = {}

Kona.Scenes.drawCurrent = ->
  @currentScene.draw()

Kona.Scenes.setCurrent = (sceneName) ->
  # @currentScene.active = false
  # @currentScene = Kona.Utils.findByKey(@scenes, 'name', sceneName)
  # @currentScene.active = true


class Kona.Scene
  constructor: (options={}) ->
    @active         = options.active || false
    @name           = options.name   || throw new Error("scene must have a name")
    @background     = new Image()
    @background.src = options.background || ''
    @entities       = []

    Kona.Scenes.scenes.push(@)

  addEntity: (entity) ->
    @entities.push(entity)

  loadEntities: (entities) ->
    for entity in entities
      @addEntity(entity)

  update: ->

  draw: ->
    # Render onto main canvas
    Kona.debug "will draw: #{@background}"
    #Kona.Engine.ctx.drawImage(@background, 0, 0)

