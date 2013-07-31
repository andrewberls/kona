class Elevator extends Kona.Trigger
  @group = 'elevators'

  constructor: (opts={}) ->
    super(opts)
    @solid = true
    @speed ||= 3
    @pickupSound = ''

    @isAscending  = false
    @isDescending = false

    @minHeight = @top()                # Where to stop after coming back down
    @maxHeight   = opts.maxHeight      # Max lift height (of top)
    @maxStay     = opts.maxStay || 150 # Duration to stay at top, in ticks
    @topDuration = 0 # TODO: bottomDuration

    @tolerance = 4


  atTop: -> @top() <= @maxHeight

  atBottom: -> @top() >= @minHeight


  # Check if an entity is within a given activation tolerance range
  # TODO: refactor this to trigger (and include sensitivities)
  withinTolerance: (ent) ->
    ent.bottom() >= @top()-@tolerance &&
    ent.bottom() <= @top()+@tolerance


  # Activate and move if collector within a given tolerance range
  # TODO: add maxStay at bottom and refactor
  update: ->
    if @atTop()
      if @topDuration >= @maxStay
        # At top past stay, now descending
        @isDescending = true
      else
        # Landed at top
        @isAscending = @isDescending = false
        @topDuration++

    # Need topDuration check for initial lift, otherwise stuck at bottom
    if @atBottom() && @topDuration != 0
      # Landed at bottom
      @topDuration = 0
      @isAscending = @isDescending = false

    else if @isDescending && !@atBottom()
      @position.y += @speed # Move down

    else if @isAscending && !@atTop()
      @position.y -= @speed # Move up

    else
      for ent in Kona.Collectors.for(@group)
        if ent.inColumnSpace(@) && @withinTolerance(ent) && @atBottom()
          @isAscending = true
