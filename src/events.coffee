# An interface for binding to generic events, that can be triggered at any point
# You must first bind a function to an event name, and then you can
# trigger that function by name.
# You can bind multiple functions to a single event name - they will trigger simultaneously
#
#
# Ex:
#
#     Kona.Events.bind "sayHello", -> console.log "Hello World!"
#     Kona.Events.trigger("sayHello")
#

Kona.Events =

  store: new Kona.Store

  # Save an event binding
  bind: (name, handler) -> @store.add(name, handler)


  # Invoke a handler function
  # Do nothing if no event associated with name
  trigger: (name) -> handler.call() for handler in @store.get(name)



# Alias `bind()` as `on()`
# Ex: `Kona.Events.on "s2_activate", -> console.log "Scene 2 activated!"`
Kona.Events.on = Kona.Events.bind
