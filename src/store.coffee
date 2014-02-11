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


  # Public: Get the array of values stored at a certain key(s)
  #
  # key - Varargs list of String keys
  #       Returns a single flattened list of values if multiple keys given
  #
  # Ex:
  #
  #     store.get("myKey")
  #     #  => ["myData"]
  #
  #     store.get("myKey1", "myKey2")
  #     #  => ["key1Data", "key2Data"]
  #
  #     store.get("fakeKey")
  #     #  => []
  #
  # Returns Array of values stored at key or [] if key not found
  #
  get: (key) ->
    # TODO: ref/copy issues
    # _.reduce keys, ( (result, key) => result.concat(@_store[key] || []) ), []
    @_store[key] || []


  # Internal: Return all key/value pairs in the store
  # Used internally for rendering and collisions
  #
  # Returns Hash of keys -> [values]
  #
  all: -> @_store


  # Delete all values for `key` if one is provided,
  # else reset the entire store
  #
  # Returns nothing
  reset: (key) ->
    if key?
      @_store[key] = []
    else
      @_store = []


  # Internal: Return shallow copy Array of all values combined
  # See https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/concat
  concat: ->
    result = []
    for key, vals of @all()
      result = result.concat(vals)
    result



  # Alias `set()` as `add()`
  # Ex: `store.add("myKey", "myData")
  @::add = @::set


  # Alias `get()` as `for()`
  # Ex: `Kona.Collectors.for('coins') => [Player]
  @::for = @::get
