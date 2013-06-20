# An implementation of a QuadTree, a 2d spatial subdivision algorithm
#
# Original JS implementation by Mike Chambers (https://github.com/mikechambers/ExamplesByMesh/tree/master/JavaScript/QuadTree),
#   with modifications by Andrew Berls
#
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



# QuadTree data structure
#
# @param {Object} bounds
#    An object representing the bounds of the top level of the QuadTree.
#    The object should contain the properties: x, y, width, height
#
# @param {Number} maxDepth
#     The maximum number of levels that the quadtree will create.
#     Default is 4.
#
# @param {Number} maxChildren
#     The maximum number of children that a node can contain before it is split into sub-nodes.
#     Default is 4.
#
class window.QuadTree
  constructor: (bounds, maxDepth, maxChildren) ->
    @root = new Node(bounds, 0, maxDepth, maxChildren)


  # Inserts an item into the tree
  #
  # @param {Object|Array} item
  #     The item or Array of items to be inserted into the QuadTree. The item should contain the properties: x, y
  #
  insert: (item) ->
    if item instanceof Array
      @root.insert(i) for i in item
    else
      @root.insert(item)


  # Clears all nodes and children from the tree
  clear: -> @root.clear()


  # Retrieves a copy of all items in the same node as the specified item. If the specified item
  # overlaps the bounds of a node, then all children in both nodes will be returned.
  #
  # @param {Object} item
  #     An object representing a 2D coordinate point (with x, y properties), or a shape
  #     with dimensions (x, y, width, height) properties.
  #
  retrieve: (item) ->
    @root.retrieve(item).slice(0)
