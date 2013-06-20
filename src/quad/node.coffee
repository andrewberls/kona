# A bounded node data structure

class Node
  @TOP_LEFT     = 0
  @TOP_RIGHT    = 1
  @BOTTOM_LEFT  = 2
  @BOTTOM_RIGHT = 3

  constructor: (bounds, depth, maxDepth, maxChildren) ->
    @bounds        = bounds
    @children      = []
    @stuckChildren = []
    @nodes         = []
    @depth         = depth       || 0
    @maxDepth      = maxDepth    || 4
    @maxChildren   = maxChildren || 4

  # Internal: TODO - docs
  insert: (item) ->
    if @nodes.length
      index = @findIndex(item)
      node  = @nodes[index]

      ix      = item.position.x
      iy      = item.position.y
      iwidth  = item.box.width
      iheight = item.box.height

      if (ix >= node.bounds.x &&
        ix + iwidth <= node.bounds.x + node.bounds.width &&
        iy >= node.bounds.y &&
        iy + iheight <= node.bounds.y + node.bounds.height)
          @nodes[index].insert(item)
      else
        @stuckChildren.push(item)
      return

    @children.push(item)

    if !(@_depth >= @_maxDepth) && (@children.length > @maxChildren)
      @subdivide()
      @insert(child) for child in @children
      @children = []


  # Internal: TODO - docs
  findIndex: (item) ->
    ix      = item.position.x
    iy      = item.position.y

    b = @bounds
    left = !(ix > b.x + b.width / 2)
    top  = !(iy > b.y + b.height / 2)

    # Top left
    index = Node.TOP_LEFT
    if left
      # Left side
      index = Node.BOTTOM_LEFT if (!top)
    else
      # Right side
      if top
        index = Node.TOP_RIGHT
      else
        index = Node.BOTTOM_RIGHT

    return index


  # Internal: retrieve an item
  # Return TODO
  retrieve: (item) ->
    out = []

    if @nodes.length
      index = @findIndex(item)
      out.push.apply(out, @nodes[index].retrieve(item))
      return out

    out.push.apply(out, @stuckChildren)
    out.push.apply(out, @children)
    return out


  # Internal: All children of this node
  # Return TODO - docs
  getChildren: ->
    @children.concat(this.stuckChildren)


  # Internal: Divide this node into 4 subnodes
  # Return TODO - docs
  subdivide: ->
    depth = @_depth + 1
    b_x   = @bounds.x
    b_y   = @bounds.y

    # Floor the values
    half_width  = (@bounds.width / 2)  | 0
    half_height = (@bounds.height / 2) | 0
    x_mid = b_x + half_width
    y_mid = b_y + half_height

    # top left
    @nodes[Node.TOP_LEFT] = new Node {
      x: b_x,
      y: b_y,
      width: half_width,
      height: half_height
    }, depth

    # top right
    @nodes[Node.TOP_RIGHT] = new Node {
      x: x_mid,
      y: b_y,
      width: half_width,
      height: half_height
    }, depth

    # bottom left
    @nodes[Node.BOTTOM_LEFT] = new Node {
      x: b_x,
      y: y_mid,
      width: half_width,
      height: half_height
    }, depth

    # bottom right
    @nodes[Node.BOTTOM_RIGHT] = new Node {
      x: x_mid,
      y: y_mid,
      width: half_width,
      height: half_height
    }, depth


  # Internal: Clear all children from all child nodes
  clear: ->
    @stuckChildren.length = 0
    @children.length      = 0

    return unless @nodes.length
    node.clear() for node in @nodes

    @nodes.length = 0
