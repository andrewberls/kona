class SignBackground extends Kona.Entity
  @group: 'sign_backgrounds'

  constructor: (opts={}) ->
    super(opts)
    @gravity = false
    @solid   = false


  update: ->

  # TODO: placeholder
  # draw: -> Kona.Canvas.drawRect(@position, @box, color: 'blue')


class Sign extends Kona.Trigger
  @group = 'signs'

  constructor: (opts={}) ->
    super(opts)

    # TODO: not a huge fan of this approach
    @popupOpts = opts.popupOpts || {}
    @seen = false


  showPopup: ->
    Kona.togglePause()
    @background = new SignBackground(@popupOpts)
    Kona.Scenes.currentScene.addEntity(@background)


  # Show popup if we're intersecting for first time
  activate: (ent) ->
    # super()
    if !@seen
      @showPopup()
      @seen = true



Kona.onResume ->
  for ent in Kona.Scenes.getCurrentEntities('sign_backgrounds')
    ent.destroy()
