# A manager object for all scenes. Keeps track of entity mappings / definitions,
# and handles rendering the current scene as well as transitions between scenes

Kona.Scenes =

  # Internal: list of definition maps, keyed by title
  maps: []

  # Internal: list of scenes
  scenes: []

  # Internal: Array[Kona.Entity] of entities persisting across all scenes
  persistentEntities: []


  # Public: The Kona.Scene instance that is currently drawing to the canvas
  # If addEntity() is called on a scene before the engine starts, push new entity onto the queue
  currentScene: {
    addEntity: (ent) ->
      Kona.Engine.queue -> Kona.Scenes.currentScene.addEntity(ent)
  }


  # Public: Parse and save a list of definition maps.
  # Ex defns format: `[ { name1 : map1 }, { name2 : map2 } ]`
  # TODO - DOCS
  loadDefinitions: (defns) ->
    for def in defns
      for name, map of def
        @maps.push { name: name, map: map }


  # Public: Initialize scenes in order from a list
  # TODO - DOCS
  loadScenes: (argList=[]) ->
    sceneNum = 1
    for args in argList
      scene = new Kona.Scene(Kona.Utils.merge { name: "s#{sceneNum}" }, args)
      sceneNum++


  # Internal: Draw the current scene and its entities to the canvas
  drawCurrent: -> @currentScene.draw()


  # Public: Get all entities from a group in the current scene
  #
  # group - String name of the entity group
  #
  # Ex:
  #
  #   Kona.Scenes.getCurrentEntities('enemies')
  #   # => [<Enemy>, <Enemy>]
  #
  # Returns: Array of Kona.Entity instances (or [])
  #
  getCurrentEntities: (group) -> @currentScene.entities.get(group)


  # Public: Find the new scene by name and set it to active to start rendering
  #
  # sceneName - String name of the scene
  #
  # Ex: Kona.Scenes.setCurrent('lvl1:s2')
  #
  # Raises Exception if scene not found
  # Returns nothing
  #
  setCurrent: (sceneName) ->
    @currentScene.active = false
    @currentScene = @find(sceneName) or fail("Scenes.setCurrent", "Couldn't find scene: #{sceneName}")
    @currentScene.active = true
    @currentScene.triggerActivation()


  # Public: Advance to the next scene
  # This can either be specified in order in Kona.Scenes.loadScenes,
  # or manually by setting scene.next to the name of the following scene
  nextScene: ->
    if @currentScene.next?
      @setCurrent(@currentScene.next)
    else
      sceneNum = parseInt @currentScene.name.replace('s', '')
      @setCurrent("s#{++sceneNum}")

    @currentScene.addEntity(ent) for ent in @persistentEntities


  # Public: Find a scene by its name
  #
  # name - String name of the scene to find
  #
  # Ex: Kona.Scenes.find("s2")
  #
  # Returns a Kona.Scene, or null if no scene found
  #
  find: (sceneName) ->
    Kona.Utils.find(@scenes, { name: sceneName })
