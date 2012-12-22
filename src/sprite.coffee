class Kona.Sprite
  constructor: (src='') ->
    @image     = new Image()
    @image.src = src

  setSrc: (src) -> @image.src = src

  draw: (x, y, width, height) ->
    Kona.Canvas.ctx.drawImage(@image, x, y, width, height)
