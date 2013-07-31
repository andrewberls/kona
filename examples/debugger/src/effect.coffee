class Effect extends Kona.Entity
  @group = 'effects'

  constructor: (opts={}) ->
    super(opts)
    @solid    = false
    @duration = opts.duration or fail("Effect#new", "Effect must have a duration")

    setTimeout =>
      @destroy()
    , @duration

  update: ->
