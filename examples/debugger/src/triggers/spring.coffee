class Spring extends Kona.Trigger
  @group: 'springs'

  constructor: (opts={}) ->
    super(opts)
    @tolerance   = 4
    @pickupSound = 'spring'


  # Bounce!
  activate: (ent) ->
    super()
    ent.position.y -= 20
    ent.jump(duration: 180, height: 30, force: true)


  # Check if an entity is within a given activation tolerance range
  # Must be within @tolerance pixels of top, and moving downwards (i.e., not jumping)
  withinTolerance: (ent) ->
    ent.bottom() >= @top()-@tolerance &&
    ent.bottom() <= @top()+@tolerance &&
    !ent.isJumping
