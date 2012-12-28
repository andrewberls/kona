// Generated by CoffeeScript 1.3.3
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Kona.ready(function() {
  var Coin, DirtTile, Enemy, EnemyPistol, EnemyProj, Pistol, PistolProj, Player, level1_1, level1_2, pauseMenu, player;
  Kona.Canvas.init('canvas');
  Kona.Sounds.load({
    'fire': 'audio/enemy_fire.ogg'
  });
  level1_1 = new Kona.Scene({
    name: 'lvl1:s1',
    background: 'img/backgrounds/lvl2.jpg',
    active: true
  });
  level1_2 = new Kona.Scene({
    name: 'lvl1:s2',
    background: 'img/backgrounds/lvl2.jpg'
  });
  pauseMenu = new Kona.Menu({
    name: 'pauseMenu',
    trigger: 'escape',
    options: {
      'Resume Game': function() {
        return Kona.Scenes.setCurrent('lvl1:s1');
      },
      'Something One': function() {
        return console.log("something one");
      },
      'Something Two': function() {
        return console.log("something two");
      }
    }
  });
  DirtTile = (function(_super) {

    __extends(DirtTile, _super);

    function DirtTile(opts) {
      if (opts == null) {
        opts = {};
      }
      DirtTile.__super__.constructor.call(this, opts);
      this.sprite.src = 'img/tiles/dirt1.png';
    }

    return DirtTile;

  })(Kona.Tile);
  Player = (function(_super) {

    __extends(Player, _super);

    function Player(opts) {
      if (opts == null) {
        opts = {};
      }
      Player.__super__.constructor.call(this, opts);
      this.speed = 3;
      this.jumpHeight = 12;
      this.isJumping = false;
      this.facing = 'right';
      this.canFire = false;
      this.sprite.src = "img/entities/player_" + this.facing + ".png";
      this.currentWeapon = null;
      this.collects('coins', 'weapons');
    }

    Player.prototype.update = function() {
      Player.__super__.update.apply(this, arguments);
      this.sprite.src = "img/entities/player_" + this.facing + ".png";
      if (this.isJumping) {
        this.position.y -= this.jumpHeight;
        this.correctTop();
      } else {
        this.addGravity();
      }
      if (this.top() > Kona.Canvas.height) {
        return this.die();
      }
    };

    Player.prototype.jump = function() {
      var jumpDuration,
        _this = this;
      jumpDuration = 180;
      if (this.isJumping) {
        return false;
      } else if (this.onSurface()) {
        this.isJumping = true;
        this.position.y -= 20;
        return setTimeout(function() {
          return _this.isJumping = false;
        }, jumpDuration);
      }
    };

    Player.prototype.fire = function() {
      if (this.currentWeapon != null) {
        return this.currentWeapon.fire();
      }
    };

    Player.prototype.die = function() {
      var _this = this;
      return setTimeout(function() {
        _this.facing = 'right';
        return _this.setPosition(195, 200);
      }, 400);
    };

    return Player;

  })(Kona.Entity);
  Enemy = (function(_super) {

    __extends(Enemy, _super);

    function Enemy(opts) {
      if (opts == null) {
        opts = {};
      }
      Enemy.__super__.constructor.call(this, opts);
      this.currentWeapon = new EnemyPistol({
        group: 'enemy_weapons',
        holder: this
      });
      level1_1.addEntity(this.currentWeapon);
    }

    Enemy.prototype.update = function() {
      Enemy.__super__.update.apply(this, arguments);
      return this.addGravity();
    };

    Enemy.prototype.destroy = function() {
      this.currentWeapon.destroy();
      return Enemy.__super__.destroy.apply(this, arguments);
    };

    return Enemy;

  })(Kona.Entity);
  Coin = (function(_super) {

    __extends(Coin, _super);

    function Coin() {
      return Coin.__super__.constructor.apply(this, arguments);
    }

    Coin.prototype.activate = function(collector) {
      return puts("Coin activated!");
    };

    return Coin;

  })(Kona.Collectable);
  Pistol = (function(_super) {

    __extends(Pistol, _super);

    function Pistol(opts) {
      if (opts == null) {
        opts = {};
      }
      Pistol.__super__.constructor.call(this, opts);
      this.recharge = 150;
      this.projType = PistolProj;
      this.projSound = 'fire';
    }

    return Pistol;

  })(Kona.Weapon);
  PistolProj = (function(_super) {

    __extends(PistolProj, _super);

    function PistolProj(opts) {
      if (opts == null) {
        opts = {};
      }
      PistolProj.__super__.constructor.call(this, opts);
      this.destructibles = ['enemies'];
      this.box = {
        width: 15,
        height: 10
      };
    }

    PistolProj.prototype.draw = function() {
      var _this = this;
      return Kona.Canvas.safe(function() {
        Kona.Canvas.ctx.fillStyle = 'blue';
        return Kona.Canvas.ctx.fillRect(_this.position.x, _this.position.y, _this.box.width, _this.box.height);
      });
    };

    return PistolProj;

  })(Kona.Projectile);
  EnemyProj = (function(_super) {

    __extends(EnemyProj, _super);

    function EnemyProj(opts) {
      if (opts == null) {
        opts = {};
      }
      EnemyProj.__super__.constructor.call(this, opts);
      this.destructibles = [];
    }

    return EnemyProj;

  })(PistolProj);
  EnemyPistol = (function(_super) {

    __extends(EnemyPistol, _super);

    function EnemyPistol(opts) {
      var _this = this;
      if (opts == null) {
        opts = {};
      }
      EnemyPistol.__super__.constructor.call(this, opts);
      this.target = player;
      this.recharge = 1000;
      this.projType = EnemyProj;
      setInterval(function() {
        return _this.fire();
      }, this.recharge);
    }

    EnemyPistol.prototype.draw = function() {
      var _this = this;
      return Kona.Canvas.safe(function() {
        Kona.Canvas.ctx.fillStyle = 'red';
        return Kona.Canvas.ctx.fillRect(_this.position.x, _this.position.y, _this.box.width, _this.box.height);
      });
    };

    return EnemyPistol;

  })(Kona.EnemyWeapon);
  player = new Player({
    x: 100,
    y: 100,
    width: 200,
    height: 200,
    color: 'black',
    group: 'player'
  });
  player.loadAnimations({
    'idle': {
      sheet: 'img/entities/robot_sheet.png',
      width: 200,
      height: 200
    }
  });
  player.setAnimation('idle');
  level1_1.addEntity(player);
  Kona.Keys.keydown = function(key) {
    switch (key) {
      case 'left':
        return player.direction.dx = -1;
      case 'right':
        return player.direction.dx = 1;
      case 'up':
        return player.jump();
      case 'space':
        return player.fire();
    }
  };
  Kona.Keys.keyup = function(key) {
    switch (key) {
      case 'left':
      case 'right':
        return player.stop('dx');
      case 'up':
      case 'down':
        return player.stop('dy');
    }
  };
  Kona.Scenes.definitionMap = {
    '-': {
      group: 'tiles',
      klass: Kona.BlankTile
    },
    'r': {
      group: 'tiles',
      klass: DirtTile,
      opts: {
        sprite: ''
      }
    },
    'o': {
      group: 'tiles',
      klass: DirtTile,
      opts: {
        sprite: ''
      }
    },
    'b': {
      group: 'tiles',
      klass: DirtTile,
      opts: {
        sprite: ''
      }
    },
    'x': {
      group: 'enemies',
      klass: Enemy,
      opts: {
        width: 40,
        height: 60,
        offset: {
          x: 15
        },
        sprite: 'img/entities/ninja1.png'
      }
    },
    'c': {
      group: 'coins',
      klass: Coin,
      opts: {
        width: 25,
        height: 25,
        offset: {
          x: 20,
          y: 20
        },
        sprite: 'img/powerups/coin.png'
      }
    },
    'p': {
      group: 'weapons',
      klass: Pistol,
      opts: {
        width: 50,
        height: 25,
        offset: {
          x: 15,
          y: 15
        },
        sprite: 'img/weapons/pistol.png'
      }
    }
  };
  level1_1.loadEntities([['-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-'], ['-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-'], ['-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-'], ['-', '-', '-', '-', '-', '-', '-', '-', '-', 'o', 'b'], ['r', 'b', '-', '-', '-', '-', '-', '-', 'r', '-', '-'], ['o', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-'], ['r', 'c', 'c', 'o', 'p', '-', 'b', 'o', '-', '-', '-'], ['b', 'o', 'r', 'b', 'r', '-', '-', 'r', 'o', '-', 'r']]);
  level1_2.loadEntities([['-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-'], ['-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-'], ['-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-'], ['b', 'r', 'o', '-', '-', '-', '-', '-', '-', '-', '-'], ['-', '-', '-', '-', '-', 'r', 'r', 'r', '-', '-', '-'], ['-', '-', '-', '-', 'r', 'r', '-', '-', '-', '-', '-'], ['-', '-', '-', 'r', 'r', 'c', '-', '-', '-', 'r', 'r'], ['o', 'b', '-', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r']]);
  return Kona.Engine.start();
});
