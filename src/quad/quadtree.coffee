# An implementation of a QuadTree, a 2d spatial subdivision algorithm
#
# Original JS implementation by Mike Chambers
# https://github.com/mikechambers/ExamplesByMesh/tree/master/JavaScript/QuadTree
# with modifications by Andrew Berls
#
# The MIT License
#
# Copyright (c) 2011 Mike Chambers
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.



# Public: QuadTree constructor
#
# bounds - Hash of attributes representing the bounds of the top level of the QuadTree
#    x  - Integer x-coordinate of the top level, in pixels
#    y  - Integer y-coordinate of the top level, in pixels
#    width  - Integer width of the top level, in pixels
#    height - Integer height of the top level, in pixels
#
# maxDepth    - Integer number of maximum levels that the QuadTree will create (Default: 4)
#
# maxChildren - Integer number of maximum children that a node can contain before
#               it is split into sub-nodes (Default: 4)
#
class window.QuadTree
  constructor: (bounds, maxDepth, maxChildren) ->
    @root = new Node(bounds, 0, maxDepth, maxChildren)


  # Public: Inserts an item into the tree
  #
  # item - Kona.Entity or Array[Kona.Entity]
  #
  # Returns nothing
  #
  insert: (item) ->
    if _.isArray(item)
      @root.insert(i) for i in item
    else
      @root.insert(item)


  # Public: Clears all nodes and children from the tree
  # Returns nothing
  clear: -> @root.clear()


  # Public: Retrieves a copy of all items in the same node as the specified item.
  # If the specified item overlaps the bounds of a node, then
  # all children in both nodes will be returned.
  #
  # item - Kona.Entity to retrieve neighbors of
  #
  # Returns Array[Kona.Entity] # TODO
  #
  retrieve: (item) ->
    @root.retrieve(item).slice(0)
