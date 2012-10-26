Kona = window.Kona = {}

# Debug helpers
# Set this to true to log info to the console
# Make sure to disable for production dists
Kona.debugMode = true



# Log a message or inspect an object for debugging
#
# Usage:
#   Logging strings:
#     Kona.debug "Some useful information" # => "Some useful information"
#
#   Inspecting objects:
#     var car = { color: 'red', drive: function() {} }
#
#     Kona.debug(car)
#       Dumping object:
#         color: red
#         drive(): <function>
Kona.debug = (obj) ->
  if Kona.debugMode
    log = (msg) -> console.log(msg) # Sugar method

    defined_str = if obj? then '' else '<undefined>'
    spacer      = "  "  # Indent results
    is_array    = _.isArray obj
    is_string   = _.isString obj
    is_number   = _.isNumber obj
    is_boolean  = _.isBoolean obj
    is_object   = _.isObject obj

    log "<undefined>" unless obj?

    if is_array || is_object
      log "Dumping #{ if is_array then 'array' else typeof obj}: #{defined_str}"

    if is_array
      log "#{spacer}[#{obj}]"    # [1,2,3]
    else if is_string
      log obj                    # "test"
    else if is_number
      log obj                    # 5
    else if is_boolean           # "true"
      log obj.toString()
    else if is_object
      for own key, value of obj  # x: 25
        if _.isFunction(value)
          log "#{spacer}#{key}(): <function>"
        else
          log "#{spacer}#{key}: #{value}"

Kona.readyCallbacks = []
Kona.isReady = false


Kona.ready = (callback) ->
  if document.readyState == 'complete'
    Kona.isReady = true

  # If the DOM is already ready, just invoke the callback.
  if Kona.isReady
    callback.call()

  Kona.readyCallbacks.push(callback)


# Internal function hooked to the DOM's ready event.
Kona.DOMContentLoaded = ->
  return if Kona.isReady # Do nothing if already ready
  Kona.isReady = true
  for callback in Kona.readyCallbacks
    callback.call()

# Hook the various DOM loaded events. Borrowed from jQuery's implementation.
# TODO: CHECK FOR EVENT SUPPORT
if document.readyState != 'complete'
  if document.addEventListener
    document.addEventListener('DOMContentLoaded', Kona.DOMContentLoaded, false)
    window.addEventListener('load', Kona.DOMContentLoaded, false)

  else if document.attachEvent
    document.attachEvent('onreadystatechange', Kona.DOMContentLoaded)
    window.attachEvent('onload', Kona.DOMContentLoaded)
