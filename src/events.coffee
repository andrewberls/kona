Kona.Events =
  # Contains info on keys and their associated handler(s)
  # Ex format:
  #   'enemy:die' : [ <function>, <function> ]
  #   'spawn' : [ <function> ]
  _handlers: {}

  bind: (name, handler) ->
    @_handlers[name] ||= []
    @_handlers[name].push(handler)

  trigger: (name) ->
    # Call the handler and stop further event propagation
    for handler in @_handlers[name]
      handler.call()
