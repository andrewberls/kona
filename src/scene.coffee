# A scene represents a distinct game state, such as a menu or a level.
# Entities are added to a particular scene, and the engine takes care of
# rendering the current scene.


Kona.Scenes = {}

Kona.Scenes.scenes = [] # TODO: better naming
Kona.Scenes.currentScene = {}

Kona.Scenes.renderCurrent = ->
  Kona.Scenes.currentScene.render()


class Kona.Scene
  constructor: ->
    @active = false
    @entities = []

  addEntity: (entity) ->
    @entities.push(entity)

  loadEntities: (entities) ->
    _.each entities, (entity) ->
      @addEntity(entity)

  update: ->

  draw: ->
    # Load into back buffer?

