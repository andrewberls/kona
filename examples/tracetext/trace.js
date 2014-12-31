(function() {
  var Tracer, addTracer, cycle, randomMotion, randomSpeed, randomX, randomY, tracerColors,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  tracerColors = ['#1B184F', '#312c91', '#423ac0', '#9c4274'];

  Tracer = (function(_super) {

    __extends(Tracer, _super);

    Tracer.group = 'tracers';

    function Tracer(opts) {
      if (opts == null) {
        opts = {};
      }
      Tracer.__super__.constructor.call(this, opts);
      this.gravity = false;
      this.box = {
        width: 10,
        height: 10
      };
      this.color = Kona.Utils.sample(tracerColors);
      this.lifetime = 3;
      this.pixels = [];
      this.pixelSize = 2;
      this.pixelColor = '#b8b8b8';
      this.pushFlag = 0;
      this.pushLimit = 5;
      this.sweepFlag = 0;
      this.sweepLimit = 7;
    }

    Tracer.prototype.drawPixels = function() {
      var pixel, _i, _len, _ref, _results,
        _this = this;
      _ref = this.pixels;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        pixel = _ref[_i];
        _results.push(Kona.Canvas.safe(function() {
          Kona.Canvas.ctx.fillStyle = _this.pixelColor;
          return Kona.Canvas.ctx.fillRect(pixel.x, pixel.y, _this.pixelSize, _this.pixelSize);
        }));
      }
      return _results;
    };

    Tracer.prototype.update = function() {
      Tracer.__super__.update.call(this);
      if (this.left() <= 0 || this.right() >= Kona.Canvas.width) {
        this.lifetime -= 1;
        this.direction.dx *= -1;
      }
      if (this.top() <= 0 || this.bottom() >= Kona.Canvas.height) {
        this.lifetime -= 1;
        this.direction.dy *= -1;
      }
      this.drawPixels();
      if (this.pushFlag === 0) {
        this.pixels.push({
          x: this.midx(),
          y: this.midy()
        });
      }
      if (this.sweepFlag === 0) {
        this.pixels.shift();
      }
      this.pushFlag = cycle(this.pushFlag, this.pushLimit);
      this.sweepFlag = cycle(this.sweepFlag, this.sweepLimit);
      if (this.lifetime === 0) {
        return Kona.Scenes.currentScene.removeEntity(this);
      }
    };

    Tracer.prototype.draw = function() {
      var _this = this;
      return Kona.Canvas.safe(function() {
        return Kona.Canvas.drawRect(_this.position, _this.box, {
          color: _this.color
        });
      });
    };

    return Tracer;

  })(Kona.Entity);

  cycle = function(num, limit) {
    if (num > limit) {
      return 0;
    } else {
      return num + 1;
    }
  };

  randomMotion = function() {
    var res;
    res = Kona.Utils.random(-2, 2);
    if (res === 0) {
      return randomMotion();
    } else {
      return res;
    }
  };

  randomSpeed = function() {
    return Kona.Utils.sample(Kona._.range(0.5, 1, 0.1));
  };

  randomX = function() {
    return Kona.Utils.random(0, Kona.Canvas.width);
  };

  randomY = function() {
    return Kona.Utils.random(0, Kona.Canvas.height);
  };

  addTracer = function(opts) {
    var tracer;
    tracer = new Tracer(opts);
    return Kona.Scenes.currentScene.addEntity(tracer);
  };

  Kona.ready(function() {
    var main;
    Kona.Canvas.init('gameCanvas');
    main = new Kona.Scene({
      name: 'main',
      active: true
    });
    addTracer({
      x: 200,
      y: 200,
      dx: -2,
      dy: -1,
      speed: 0.75
    });
    setInterval(function() {
      return addTracer({
        x: randomX(),
        y: randomY(),
        dx: randomMotion(),
        dy: randomMotion(),
        speed: randomSpeed()
      });
    }, 3000);
    return Kona.Engine.start();
  });

}).call(this);
