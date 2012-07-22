// Generated by CoffeeScript 1.3.3

Kona.Entity = (function() {

  function Entity() {
    this.position = {
      x: 0,
      y: 0
    };
    this.direction = {
      dx: 0,
      dy: 0
    };
    this.box = {
      width: 0,
      height: 0
    };
    this.sprite = new Image();
    this.sprite.src = '';
  }

  Entity.prototype.update = function() {
    this.position.x += this.direction.dx;
    return this.position.y += this.direction.dy;
  };

  Entity.prototype.draw = function() {
    return Kona.Engine.ctx.drawImage(this.sprite, this.position.x, this.position.y);
  };

  return Entity;

})();
