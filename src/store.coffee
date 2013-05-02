# An generic interface for a 'bucket store' of arbitrary keys and values,
# where values with the same key are kept in an array.
#

class Kona.Store
  constructor: ->
    @_store = {}


  # Store a key and a value
  # Returns the list of values stored at "myKey"
  #
  # Ex:
  #
  #     store.set("myKey", "one")
  #       => ["one"]
  #
  #     store.set("myKey", "two")
  #       => ["one", "two"]
  #
  set: (key, val) ->
    @_store[key] ||= []
    @_store[key].push(val)
    @_store[key]


  # Get the array of values stored at a certain key
  # Returns empty array if key not found
  #
  # Ex:
  #
  #     store.get("myKey")
  #       => ["myData"]
  #
  #     store.get("fakeKey")
  #       => []
  #
  get: (key) -> @_store[key] || []


  # Return all key/value pairs in the store
  # Used internally for rendering and collisions
  all: -> @_store


  # Alias `set()` as `add()`
  # Ex: `store.add("myKey", "myData")
  @::add = @::set


  # Alias `get()` as `for()`
  # Ex: `Kona.Collectors.for('coins') => [Player]
  @::for = @::get




window.store = new Kona.Store
