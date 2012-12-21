Kona.Utils =

  # A thin wrapper for _.where(). Returns the first value containing
  # all of the key-value pairs listed in `props`
  #
  # * __list__: (Array) A list of values
  # * __props__: (Object) A set of key-value properties to search for
  #
  # Ex:
  #
  #     cars = [
  #       { color: 'red', owner: 'Jon' },
  #       { color: 'green', owner: 'Jane' }
  #     ]
  #     Kona.Utils.find(cars, { 'color': 'red' })
  #     => { color: 'red', owner: 'Jon' }
  find: (list, props) ->
    _.where(list, props)[0]

  # Generate a random integer within range (inclusive)
  randomFromTo: (from, to) ->
    Math.floor(Math.random() * (to - from + 1) + from)

  # Modify obj1 to also contain the contains of obj2
  # The value for entries with duplciate keys will be that of obj2
  merge: (obj1, obj2) ->
    obj1[attr] = obj2[attr] for attr of obj2
    obj1



  # ----------------------
  #   DEBUGGING UTILS
  # ----------------------
  # Print a 2d array in a grid format
  #
  # Ex:
  #
  #     printGrid [[1,2], [3,4]]
  #       [
  #         [1, 2]
  #         [3, 4]
  #       ]
  printGrid: (grid) ->
    output = "[\n"

    for row in grid
      output += "  ["
      for item, idx in row
        output += "#{item}"
        output += ", " unless idx == row.length-1
      output += "]\n"

    console.log "#{output}]"


# Do something only once (useful for debugging within run loops).
#
# Ex:
#
#     while true
#       once -> console.log "This will only be logged once"
window._k_once = 0; window.once = (fxn) -> fxn() if window._k_once == 0; window._k_once++


# Throw an exception with a message
#
# Ex: `player.name? or fail("Name is required")`
window.fail = (msg) -> throw new Error(msg)
