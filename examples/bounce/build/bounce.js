(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Kona.ready(function() {
    var Shape, main, square;
    Kona.Canvas.init('gameCanvas');
    main = new Kona.Scene({
      name: 'main',
      active: true
    });
    Shape = (function(_super) {

      __extends(Shape, _super);

      function Shape(opts) {
        if (opts == null) {
          opts = {};
        }
        opts.group || (opts.group = 'shapes');
        Shape.__super__.constructor.call(this, opts);
        this.gravity = false;
      }

      Shape.prototype.update = function() {
        Shape.__super__.update.call(this);
        if (this.left() <= 0 || this.right() >= Kona.Canvas.width) {
          this.direction.dx *= -1;
        }
        if (this.top() <= 0 || this.bottom() >= Kona.Canvas.height) {
          return this.direction.dy *= -1;
        }
      };

      Shape.prototype.draw = function() {
        var _this = this;
        return Kona.Canvas.safe(function() {
          return Kona.Canvas.drawRect(_this.position, _this.box, {
            color: 'blue'
          });
        });
      };

      return Shape;

    })(Kona.Entity);
    square = new Shape({
      x: 200,
      y: 200,
      width: 20,
      height: 20,
      dx: -2,
      dy: -1,
      speed: 3
    });
    main.addEntity(square);
    return Kona.Engine.start();
  });

}).call(this);
