# A scene represents a distinct game state, such as a menu or a level.
# Entities are added to a particular scene, and the engine takes care of
# rendering the current scene.


Kona.Scenes =
  _scenes: []

  currentScene: {}

  drawCurrent: ->
    @currentScene.draw()

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
    @entities       = [] # TODO: entity loader

    Kona.Scenes._scenes.push(@)

  addEntity: (entity) ->
    @entities.push(entity)

  loadEntities: (entities) ->
    for entity in entities
      @addEntity(entity)

  update: ->

  draw: ->
    # Render onto main canvas
    Kona.debug "will draw: #{@name}"
    # drawImage(image, srcX, srcY, srcWidth, srcHeight, destX, destY, destWidth, destHeight)
    Kona.Engine.ctx.drawImage(@background, 0, 0)
    # entity.draw() for entity in @entities
