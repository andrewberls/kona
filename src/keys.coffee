# Listen for keypresses and dispatch to handlers
# Based on keymaster.js by Thomas Fuchs
# https://github.com/madrobby/keymaster/


# Two main steps:
#   bind: define a handler function for a key
#   dispatch: invoke the associated handler when a bound key is pressed


Kona.Keys =
  # Contains info on keys on their associated handler(s)
  # Ex format:
  #   65: [ <function>, <function> ]
  #   17: [ <function> ]
  _handlers: {}

  # Keycode map for special keys
  _map: {
    enter: 13, return: 13,
    esc: 27, escape: 27,
    space: 32,
    shift: 16,
    ctrl: 17, control: 17,
    left: 37, up: 38,
    right: 39, down: 40,
  }


  # Parse and save key binding/handler
  # Usage: Kona.keys.bind 'a', -> console.log "You pressed a!"
  bind: (key, handler) ->
    key = key.replace(/\s/g,'') # Strip any whitespace from key selector
    Kona.debug "binding on key: '#{key}' (normalized to code: #{Kona.Keys._map[key] || key.toUpperCase().charCodeAt(0)})"

    # Convert to keycode
    key = Kona.Keys._map[key] || key.toUpperCase().charCodeAt(0)

    # Store handler
    if !Kona.Keys._handlers[key]?
      Kona.debug "  key #{key} not found in existing handlers, setting to []\n"
      Kona.Keys._handlers[key] = []

    Kona.Keys._handlers[key].push(handler)


  # Respond to keydown event and call associated handler
  dispatch: (event) ->
    key = event.keyCode # TODO: normalize (event.which ?)
    Kona.debug "\ndispatching key: #{key}"
    Kona.debug "  no handler found, ABORT" if !Kona.Keys._handlers[key]?

    # Abort if we're in a data input element or no matching handlers found
    return if Kona.Keys.reject(event) || !Kona.Keys._handlers[key]?

    # Call the handler and stop further event propagation
    for handler in Kona.Keys._handlers[key]
      handler.call()

      if event.preventDefault
        event.preventDefault()
      else
        event.returnValue = false

      event.stopPropagation() if event.stopPropagation
      event.cancelBubble = true if event.cancelBubble


  reject: (event) ->
    # Ignore keypresses from elements that take keyboard data input
    tagName = (event.target || event.srcElement).tagName
    Kona.debug "  data input - REJECT" if _.include(['INPUT', 'SELECT', 'TEXTAREA'], tagName)
    _.include(['INPUT', 'SELECT', 'TEXTAREA'], tagName)


  # Cross-browser event listeners
  addEvent: (object, event, method) ->
    if object.addEventListener
      object.addEventListener(event, method, false)
    else if object.attachEvent
      object.attachEvent "on#{event}", ->
        method(window.event)


Kona.ready ->
  # Set global key dispatch on the document
  Kona.Keys.addEvent(document, 'keydown', Kona.Keys.dispatch)
