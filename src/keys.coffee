# An interface for binding actions to keypresses, loosely
# based on [keymaster.js by Thomas Fuchs](https://github.com/madrobby/keymaster/)
#
# __There are two ways to bind actions to keys:__
#
# 1) Define the `Kona.Keys.keydown()` function to handle events
#
# This function is directly bound the DOM keydown event, and will be
# called with the __name__ of each pressed key. For example:
#
#       Kona.Keys.keydown = (key) ->
#         switch key
#           when 'left'  then player.direction.dx = -1
#           when 'right' then player.direction.dx = 1
#           when 'up'    then player.jump()
#           when 'space' then player.fire()
#
# 2) Bind a handler function to a specific key. The method takes a string name and
# callback function invoked whenever that key is pressed.
#
#       Kona.Keys.bind 'a', ->
#         console.log "You pressed a!"


Kona.Keys =
  # Contains info on keys and their associated handler(s)
  # Example structure:
  #
  #       65: [ <function>, <function> ]
  #       17: [ <function> ]
  _handlers: {}

  # Mapping of special names --> keycode
  _keycodes: {
    'enter': 13, 'return': 13,
    'esc'  : 27, 'escape': 27,
    'ctrl' : 17, 'control': 17,
    'left' : 37, 'up'     : 38,
    'right': 39, 'down'   : 40,
    'shift': 16,
    'space': 32
  }

  # Mapping of Keycodes --> Names
  _names: {
    13: 'enter',
    16: 'shift',
    17: 'ctrl',
    27: 'esc',
    32: 'space',
    37: 'left',
    38: 'up',
    39: 'right',
    40: 'down',
    48: '0',
    49: '1',
    50: '2',
    51: '3',
    52: '4',
    53: '5',
    54: '6',
    55: '7',
    56: '8',
    57: '9',
    65: 'a',
    66: 'b',
    67: 'c',
    68: 'd',
    69: 'e',
    70: 'f',
    71: 'g',
    72: 'h',
    73: 'i',
    74: 'j',
    75: 'k',
    76: 'l',
    77: 'm',
    78: 'n',
    79: 'o',
    80: 'p',
    81: 'q',
    82: 'r',
    83: 's',
    84: 't',
    85: 'u',
    86: 'v',
    87: 'w',
    88: 'x',
    89: 'y',
    90: 'z'
  }


  # Parse and save key binding/handler function pair
  #
  # * __key__ - (String) The key to bind the function to, ex: `'b'`
  #
  # Strips whitespace from key selector and converts to an internal keycode
  #
  bind: (key, handler) ->
    key     = key.replace(/\s/g, '')
    keycode = @_keycodes[key] || key.toUpperCase().charCodeAt(0)
    @_handlers[keycode] ||= []
    @_handlers[keycode].push(handler)


  # Internally invoke the associated handler function when a bound key is pressed,
  # and stops further event propagation
  dispatch: (event) ->
    keycode = @eventKeyCode(event)
    return if @reject(event) || !@_handlers[keycode]?

    for handler in @_handlers[keycode]
      handler.call(event)
      false


  # Ignore keypresses from elements that take keyboard data input,
  # such as textareas. Returns Boolean
  reject: (event) ->
    _.contains ['INPUT', 'SELECT', 'TEXTAREA'], event.target.tagName


  # Get the name of a key from a DOM event. Returns String
  keycodeName: (event) ->
    @_names[ @eventKeyCode(event) ]

  # Get the keycode for a DOM keyboard event. Returns Integer
  eventKeyCode: (event) -> event.which || event.keyCode


Kona.ready ->
  # Wire up keydown and keyup events to associated handlers if they exist
  document.body.onkeydown = (e) ->
    name = Kona.Keys.keycodeName(e)
    Kona.Keys.keydown(name) if Kona.Keys.keydown

  # Set global key dispatch on the document bound to Kona.Keys context
  document.body.onkeyup = (e) ->
    name = Kona.Keys.keycodeName(e)
    Kona.Keys.keyup(name) if Kona.Keys.keyup

  document.addEventListener('keydown', Kona.Keys.dispatch.bind(Kona.Keys), false)

