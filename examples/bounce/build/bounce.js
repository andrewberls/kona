(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Kona.ready(function() {
    var Shape, main;
    Kona.Canvas.init('canvas');
    main = new Kona.Scene({
      name: 'main',
      active: true
    });
    Shape = (function(_super) {

      __extends(Shape, _super);

      function Shape() {
        return Shape.__super__.constructor.apply(this, arguments);
      }

      Shape.prototype.update = function() {
        this.position.x += this.speed * this.direction.dx;
        this.position.y += this.speed * this.direction.dy;
        if (this.left() < 0 || this.right() > Kona.Canvas.width) {
          this.direction.dx *= -1;
        }
        if (this.top() < 0 || this.bottom() > Kona.Canvas.height) {
          return this.direction.dy *= -1;
        }
      };

      Shape.prototype.draw = function() {
        var _this = this;
        return Kona.Canvas.safe(function() {
          Kona.Canvas.ctx.fillStyle = 'blue';
          return Kona.Canvas.ctx.fillRect(_this.position.x, _this.position.y, _this.box.width, _this.box.height);
        });
      };

      return Shape;

    })(Kona.Entity);
    main.addEntity(new Shape({
      x: 200,
      y: 200,
      width: 20,
      height: 20,
      dx: -2,
      dy: -1,
      speed: 3,
      group: 'ball'
    }));
    return Kona.Engine.start();
  });

}).call(this);

