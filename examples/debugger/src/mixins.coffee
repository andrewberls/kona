Resets = {
  resetAnimation: ->
    if @direction.dx != 0
      @setAnimation("run_#{@facing}")
    else
      @setAnimation("idle_#{@facing}")
}

Paces = {
  reverse: _.throttle ->
    @direction.dx *= -1
  , 3000

  pace: ->
    if @isAlive
      if _.random(1, 100) == 1 || @left() < 0 || @right() > Kona.Canvas.width
        @reverse()
      @setAnimation("run_#{@facing}")
}
