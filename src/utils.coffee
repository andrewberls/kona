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
  #       => { color: 'red', owner: 'Jon' }
  #
  find: (list, props) ->
    _.where(list, props)[0]

  # Modify obj1 to also contain the contents of obj2
  # The value for entries with duplciate keys will be that of obj2
  # Ex:
  #
  #     obj1 = { 'a' : 100, 'b' : 200 }
  #     obj2 = { 'b' : 254, 'c' : 300 }
  #     Kona.Utils.merge(obj1, obj2)
  #       => { 'a' : 100, 'b' : 254, 'c' : 300 }
  #
  merge: (obj1, obj2={}) ->
    obj1[attr] = obj2[attr] for attr of obj2
    obj1

# Run a function only once. Useful for debugging within loops.
# Ex:
#
#     while true
#       once =>
#         console.log "This will only be logged once"
#
window.__k_once = 0
window.once = (fn) ->
  fn() if __k_once == 0
  __k_once++

# Throw an exception with a message
#
# Ex: `player.name? or fail("Name is required")`
window.fail = (msg) -> throw new Error(msg)
