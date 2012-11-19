# Listen for keypresses and dispatch to handlers
# Based on keymaster.js by Thomas Fuchs
# https://github.com/madrobby/keymaster/
#
# Two ways to bind actions to keys:
#
# 1. Directly on the keydown event
#   Kona.Keys.keydown = (key) ->
#     switch key
#       when 'left'  then shape.direction.dx = -moveSpeed
#       when 'right' then shape.direction.dx = moveSpeed
#       when 'up'    then shape.jump()
#
# 2. Bind a handler function to a keypress
#     Kona.keys.bind 'a', ->
#       console.log "You pressed a!"


Kona.Keys =
  # Contains info on keys and their associated handler(s)
  # Ex format:
  #   65: [ <function>, <function> ]
  #   17: [ <function> ]
  _handlers: {}

  # Name --> Keycode
  _keycodes: {
    'enter': 13, 'return': 13,
    'esc'  : 27, 'escape': 27,
    'ctrl' : 17, 'control': 17,
    'left' : 37, 'up'     : 38,
    'right': 39, 'down'   : 40,
    'shift': 16,
    'space': 32
  }

  # Keycode --> Name
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
  bind: (key, handler) ->
    # Strip whitespace from key selector and convert to keycode
    key     = key.replace(/\s/g, '')
    keycode = @_keycodes[key] || key.toUpperCase().charCodeAt(0)

    # Store handler
    @_handlers[keycode] ||= []
    @_handlers[keycode].push(handler)


  # Invoke the associated handler function when a bound key is pressed
  dispatch: (event) ->
    keycode = @eventKeyCode(event)
    return if @reject(event) || !@_handlers[keycode]?

    # Call the handler and stop further event propagation
    for handler in @_handlers[keycode]
      handler.call(event)
      false


  # Ignore keypresses from elements that take keyboard data input
  reject: (event) ->
    _.contains ['INPUT', 'SELECT', 'TEXTAREA'], event.target.tagName


  # Get the name of a key from an event
  keycodeName: (event) ->
    @_names[ @eventKeyCode(event) ]

  # Cross-browser access for the keycode of a keyboard event
  eventKeyCode: (event) -> event.which || event.keyCode


Kona.ready ->
  # Wire up keydown and keyup events to associated handlers if they exist
  document.body.onkeydown = (e) ->
    name = Kona.Keys.keycodeName(e)
    Kona.Keys.keydown(name) if Kona.Keys.keydown

  document.body.onkeyup = (e) ->
    name = Kona.Keys.keycodeName(e)
    Kona.Keys.keyup(name) if Kona.Keys.keyup

  # Set global key dispatch on the document bound to Kona.Keys context
  document.addEventListener('keydown', Kona.Keys.dispatch.bind(Kona.Keys), false)

