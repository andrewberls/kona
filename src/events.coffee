# An interface for binding to generic events, that can be triggered at any point
# You must first bind a function to an event name, and then you can
# trigger that function by name.
# You can bind multiple functions to a single event name - they will trigger simultaneously


Kona.Events =

  store: new Kona.Store

  # Save an event binding
  #
  # name    - String name of the event. Ex: 'player:die'
  # handler - Function to run when event is triggered
  #
  # Ex:
  #
  #     Kona.Events.bind "sayHello", -> console.log "Hello World!"
  #
  # Returns Array of all handler functions bound to <name>
  #
  bind: (name, handler) -> @store.add(name, handler)


  # Invoke a handler function associated with an event name
  # Multiple handlers can be bound to a single name key -
  # all will be invoked. Does nothing if no event associated with name
  #
  # name - String name of event
  #
  # Ex:
  #
  #     Kona.Events.bind "sayHello", -> console.log "Hello World!"
  #     Kona.Events.trigger("sayHello")
  #     => "Hello World!"
  #
  # Returns nothing
  #
  trigger: (name) -> handler.call() for handler in @store.get(name)



# Alias `bind()` as `on()`
#
# Ex:
#
#   `Kona.Events.on "s2_activate", -> console.log "Scene 2 activated!"`
#
Kona.Events.on = Kona.Events.bind
