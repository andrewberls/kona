# A scene represents a distinct game state, such as a menu or a level screen.
#
# Entities are added to a particular scene using a grid-like layout,
# which corresponds to a definition map.
#
# The engine will take care of rendering the current scene, including
# updating and drawing its associated entities, although scene
# transitions must be specified manually.


# Internal: Scene constructor
# Prefer `Kona.Scenes.loadScenes()` instead of calling this directly
#
# opts - Hash of attributes (Default: {})
#   map        - String name of the corresponding definition map. Ex: `level-1`
#   name       - String name of the scene. Ex: `lvl1:s2` (Required)
#   active     - Boolean indicating whether or not this scene is actively being drawn (Default: false)
#   background - String path to a background image. Ex: `img/jungle.png`
#   entities   - 2D grid (Array of arrays) specifying the scene's entity layout,
#                defintions from a map (specified in <map>)
#   next       - String name of the following scene. Ex: 'level-2' (Optional)
#
# Raises Exception if name not provided
#
class Kona.Scene
  constructor: (opts={}) ->
    @map            = opts.map
    @name           = opts.name or fail("Scene#new", "Scene must have a name")
    @active         = if opts.active? then opts.active else false
    @background     = new Image()
    @background.src = opts.background || ''
    @entities       = new Kona.Store
    @entityCache    = [] # Internal
    @next           = opts.next || null


    @loadEntities(opts.entities) if opts.entities?
    Kona.Scenes.scenes.push(@)


  # Add a single entity to a named group
  addEntity: (entity) ->
    entity.scene = @
    entity.loadAnimations()
    @entities.add(entity.group, entity)
    Kona.Scenes.persistentEntities.push(entity) if entity.persistent
    @expireEntityCache()


  # Internal: Initialize and construct the associated entities for a scene
  #
  # grid - A 2d grid (Array of arrays) of values to load into the scene.
  #       All values must correspond to rules in the definition map (see Scene constructor)
  #
  # An example grid might look like:
  #
  #     [
  #       ['-','-','-','-','-',],
  #       ['r','b','-','-','-',],
  #       ['o','-','-','-','-',],
  #       ['r','-','c','-','-',],
  #       ['b','o','r','b','r',]
  #     ]
  #
  # Raises exception if mapping not found
  # Returns nothing
  #
  loadEntities: (grid) ->
    x   = 0
    y   = Kona.Canvas.height - (grid.length * Kona.Tile.tileSize)
    map = Kona.Utils.find(Kona.Scenes.maps, { name: @map }).map

    for row in grid
      for def in row
        rule   = map[def] or fail("Scene#loadEntities", "No mapping found for rule: #{def}")
        offset = if rule.opts then rule.opts.offset else null
        startX = if offset? then x + (offset.x || 0) else x
        startY = if offset? then y + (offset.y || 0) else y
        opts   = Kona.Utils.merge { x: startX, y: startY, group: rule.group, scene: @ }, rule.opts
        ent    = new rule.entity(opts)
        @addEntity(ent)
        x += Kona.Tile.tileSize

      x = 0
      y += Kona.Tile.tileSize


  # Internal: Return a cached Array[Kona.Entity] or compute it
  getEntities: ->
    if @entityCache.length
      @entityCache
    else
      @entityCache = @entities.concat()

  # Internal: Force the entity cache to be recomputed
  expireEntityCache: -> @entityCache = []


  # Internal: Remove an entity from its group.
  # Prefer `entity.destroy()` instead of calling this directly.
  #
  # Returns nothing
  #
  removeEntity: (entity) ->
    list = @entities.for(entity.group)
    for ent, idx in list
      list.splice(idx, 1) if entity == ent
      @expireEntityCache()


  # Internal: Render a scene and all of its entities onto the main canvas
  # The drawing of a scene is split into two parts - updating and rendering.
  #
  # `update()` sets up the visual state of the entity before it is rendered to the screen -
  # this is where an entities position, direction, state etc should be assigned or modified.
  #
  # `draw()`  will then render the entities's visual state to the screen.
  #
  # See Kona.Entity
  #
  # Returns nothing
  #
  draw: ->
    Kona.Canvas.clear()
    Kona.Canvas.ctx.drawImage(@background, 0, 0)
    ents = @getEntities()
    for entity in ents
      if entity?
        entity.update() unless Kona.gamePaused
        entity.draw()

    @drawPauseOverlay() if Kona.gamePaused


  # Internal: Draw a transparent gray overlay over canvas if game is paused
  # TODO: issues with z-indexing here. We want sign backgrounds to take precedence over the pause box.
  drawPauseOverlay: ->
      Kona.Canvas.safe =>
        Kona.Canvas.ctx.fillStyle = "rgba(34, 34, 34, 0.6)"
        Kona.Canvas.ctx.fillRect(0, 0, Kona.Canvas.width, Kona.Canvas.height)


  # Internal: Trigger the activation event (ex: "s2_activate") for this scene
  # Called automatically when this scene becomes active
  triggerActivation: -> Kona.Events.trigger("#{@name}_activate")


  # Public: All tile entities in this scene
  #
  # Ex:
  #
  #   scene = Kona.Scenes.find("level1")
  #   scene.tiles()
  #   # => [<Tile>, <BlankTile>, <Tile>, ...]
  #
  tiles: ->
    @entities.get(Kona.Tile.group).concat(@entities.get(Kona.BlankTile.group))


  # TODO: this sucks and probably doesn't belong here
  # Internal: find a tile by position
  #
  # position -  Hash representing the coordinates of a tile
  #   x -  Integer x-coordinate of the tile, in pixels
  #   y -  Integer y-coordinate of the tile, in pixels
  #
  # Returns Kona.Tile or null if none found
  #
  findTile: (opts={}) ->
    tiles = Kona.Scenes.currentScene.tiles()
    _.find(tiles, (tile) -> tile.position.x == opts.x && tile.position.y == opts.y) || null
