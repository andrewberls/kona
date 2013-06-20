# Various utility methods for ease of development
# Note that these are in addition to the included [Underscore.js](http://underscorejs.org/) library

Kona.Utils =

  # Public:  Returns the first value containing all of the
  # key-value pairs listed in `props`.
  # A thin wrapper for _.where().
  #
  # list: An Array of values
  # props: A Hash of properties to search for
  #
  # Ex:
  #
  #     cars = [
  #       { color: 'red', owner: 'Jon' },
  #       { color: 'green', owner: 'Jane' }
  #     ]
  #     Kona.Utils.find(cars, { 'color': 'red' })
  #     #  => { color: 'red', owner: 'Jon' }
  #
  # Returns value found or null
  #
  find: (list, props={}) ->
    _.where(list, props)[0] || null


  # Public: Modify obj1 to also contain the contents of obj2
  # The value for entries with duplciate keys will be that of obj2
  # unless overwrite is explicitly set to false
  #
  # obj1 - A Hash of values
  # obj2 - A Hash of values to merge into obj1
  #
  # Ex:
  #
  #     obj1 = { 'a' : 100, 'b' : 200 }
  #     obj2 = { 'b' : 254, 'c' : 300 }
  #     Kona.Utils.merge(obj1, obj2)
  #     #  => { 'a' : 100, 'b' : 254, 'c' : 300 }
  #
  #
  #     obj1 = { 'a' : 100, 'b' : 200 }
  #     obj2 = { 'b' : 254, 'c' : 300 }
  #     Kona.Utils.merge(obj1, obj2, false)
  #     #  => { 'a' : 100, 'b' : 200, 'c' : 300 }
  #
  # Returns Object with modified contents of obj1
  #
  merge: (obj1, obj2={}, overwrite=true) ->
    for key, value of obj2
      obj1[key] = value if !obj1[key]? || overwrite
    obj1


  # Public: Return a random item from a list
  #
  # items: An Array of values
  #
  # Ex:
  #
  #     Kona.Utils.sample([1,2,3,4])
  #     #  => 2
  #     Kona.Utils.sample([1,2,3,4])
  #     #  => 4
  #
  sample: (items) ->
    items[Math.floor(Math.random() * items.length)]



# Run a function only once. Useful for debugging within loops.
#
# fn - Function to be run
#
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


# Public: Throw an exception with a message
# Accepts one or two string arguments
#
# Ex:
#     `fail("Greeter#sayMessage", "Message is required")`
#      # => "Error: In Greeter#sayMessage: Message is required"
#
# Ex:
#     `fail("Couldn't find result")`
#      # => "Error: Couldn't find result"
#
window.fail = (args...) ->
  msg = if args.length == 2 then "In #{args[0]}: #{args[1]}" else args.toString()
  throw new Error(msg)


# Shorthand for console.log, used for debugging
window.puts = (obj) -> console.log obj
