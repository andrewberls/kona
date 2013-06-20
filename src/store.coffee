# An generic interface for a 'bucket store' of arbitrary keys and values,
# where values with the same key are kept in an array.


class Kona.Store
  constructor: ->
    @_store = {}


  # Public: Store a key and a value
  #
  # key - String key to index into values
  # val - Arbitrary value to store at key
  #
  # Ex:
  #
  #     store.set("myKey", "one")
  #       => ["one"]
  #
  #     store.set("myKey", "two")
  #       => ["one", "two"]
  #
  # Returns Array of values stored at key
  #
  set: (key, val) ->
    @_store[key] ||= []
    @_store[key].push(val)
    @_store[key]


  # Public: Get the array of values stored at a certain key
  #
  # key - String key to index into values
  #
  # Ex:
  #
  #     store.get("myKey")
  #     #  => ["myData"]
  #
  #     store.get("fakeKey")
  #     #  => []
  #
  # Returns Array of values stored at key or [] if key not found
  #
  get: (key) -> @_store[key] || []


  # Internal: Return all key/value pairs in the store
  # Used internally for rendering and collisions
  #
  # Returns Hash of keys -> [values]
  #
  all: -> @_store


  # Internal: Return concatenated list of all values
  concat: ->
    result = []
    for group, ents of @all()
      result = result.concat(ents)
    result


  # Alias `set()` as `add()`
  # Ex: `store.add("myKey", "myData")
  @::add = @::set


  # Alias `get()` as `for()`
  # Ex: `Kona.Collectors.for('coins') => [Player]
  @::for = @::get
