# A scene represents a distinct game state, such as a menu or a level.
# Entities are added to a particular scene and defined in a layout.
# The engine takes care of rendering the current scene, although
# transitions must be specified manually.

Kona.Scenes =
  scenes: []
  currentScene: {}

  drawCurrent: ->
    @currentScene.draw()

  # Find the new scene by name and set it to active to start rendering
  # Ex: Kona.Scenes.setCurrent('lvl1:s2')
  setCurrent: (sceneName) ->
    @currentScene.active = false
    newScene = Kona.Utils.find(@scenes, { name: sceneName }) or throw new Error("Couldn't find scene: #{sceneName}")
    @currentScene = newScene
    @currentScene.active = true

  # Advance to the next scene for a level, assuming the name conforms to the format
  # lvl<levelNum>:s<sceneNum>
  # Ex: Level 1, Scene 2 -> 'lvl1:s2'
  nextScene: ->
    ids      = @currentScene.name.split(':')
    levelId  = ids[0]
    sceneId  = ids[1]
    sceneNum = parseInt(sceneId.replace('s', '')) + 1
    @setCurrent("#{levelId}:s#{sceneNum}")



class Kona.Scene
  constructor: (options={}) ->
    @active         = options.active || false
    @name           = options.name   || throw new Error("Scene must have a name")
    @background     = new Image()
    @background.src = options.background || ''
    @entities       = {}

    Kona.Scenes.scenes.push(@)

  # Add an entity to a namespace
  addEntity: (entity) ->
    group = entity.group or fail ("Error adding entity - must have a group")
    @entities[group] ||= []
    @entities[group].push(entity)

  # Remove an entity from a namespace
  removeEntity: (group, entity) ->
    list = @entities[group]
    for ent, idx in list
      list.splice(idx, 1) if entity == ent

  # Render onto main canvas
  draw: ->
    Kona.Canvas.clear()
    Kona.Canvas.ctx.drawImage(@background, 0, 0) # Background
    for name, list of @entities
      for entity in list
        if entity?
          entity.update()
          entity.draw()

