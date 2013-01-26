(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Kona.ready(function() {
    var Coin, Effect, Enemy, EnemyPistol, EnemyProj, Pistol, PistolProj, Player, player;
    Kona.Canvas.init('canvas');
    Kona.Sounds.load({
      'weapon_pickup': 'audio/weapon_pickup.mp3',
      'enemy_fire': 'audio/enemy_fire.ogg',
      'player_fire': 'audio/player_fire.mp3'
    });
    Player = (function(_super) {

      __extends(Player, _super);

      function Player(opts) {
        if (opts == null) {
          opts = {};
        }
        Player.__super__.constructor.call(this, opts);
        this.speed = 3;
        this.jumpHeight = 13;
        this.jumpDuration = 180;
        this.isJumping = false;
        this.facing = 'right';
        this.canFire = false;
        this.currentWeapon = null;
        this.collects('coins', 'weapons');
      }

      Player.prototype.update = function() {
        Player.__super__.update.call(this);
        if (this.isJumping) {
          this.position.y -= this.jumpHeight;
          this.correctTop();
        } else {
          this.addGravity();
        }
        if (this.top() > Kona.Canvas.height) {
          this.die();
        }
        if (this.right() > Kona.Canvas.width - 20) {
          Kona.Scenes.nextScene();
          Kona.Scenes.currentScene.addEntity(player);
          return this.setPosition(0, this.top());
        }
      };

      Player.prototype.stop = function(axis) {
        this.setAnimation("idle_" + this.facing);
        return Player.__super__.stop.call(this, axis);
      };

      Player.prototype.setDirection = function(dir) {
        this.setAnimation("run_" + dir);
        return this.direction.dx = dir === 'left' ? -1 : 1;
      };

      Player.prototype.jump = function() {
        var _this = this;
        if (!this.isJumping && this.onSurface()) {
          this.isJumping = true;
          this.position.y -= 25;
          return setTimeout(function() {
            _this.isJumping = false;
            return _this.resetAnimation();
          }, this.jumpDuration);
        }
      };

      Player.prototype.fire = function() {
        if (this.currentWeapon != null) {
          return this.currentWeapon.fire();
        }
      };

      Player.prototype.reset = function() {
        this.facing = 'right';
        this.resetAnimation();
        return this.setPosition(195, 200);
      };

      Player.prototype.resetAnimation = function() {
        if (this.direction.dx !== 0) {
          return this.setAnimation("run_" + this.facing);
        } else {
          return this.setAnimation("idle_" + this.facing);
        }
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
        Kona.Scenes.currentScene.addEntity(this.currentWeapon);
      }

      Enemy.prototype.update = function() {
        Enemy.__super__.update.call(this);
        return this.addGravity();
      };

      Enemy.prototype.destroy = function() {
        this.currentWeapon.destroy();
        return Enemy.__super__.destroy.apply(this, arguments);
      };

      return Enemy;

    })(Kona.Entity);
    Pistol = (function(_super) {

      __extends(Pistol, _super);

      function Pistol(opts) {
        if (opts == null) {
          opts = {};
        }
        Pistol.__super__.constructor.call(this, opts);
        this.recharge = 500;
        this.projType = PistolProj;
        this.projSound = 'player_fire';
      }

      Pistol.prototype.fire = function() {
        var startX;
        if (this.canFire) {
          this.holder.setAnimation("fire_" + this.holder.facing);
          startX = this.holder.facing === 'right' ? this.holder.right() + 2 : this.holder.left() - 17;
          Kona.Scenes.currentScene.addEntity(new Effect({
            group: 'effects',
            x: startX,
            y: this.holder.top() + 2,
            duration: 30,
            sprite: "img/effects/rifle_fire_" + this.holder.facing + ".png"
          }));
        }
        return Pistol.__super__.fire.call(this);
      };

      Pistol.prototype.activate = function(collector) {
        Kona.Sounds.play('weapon_pickup');
        return Pistol.__super__.activate.call(this, collector);
      };

      return Pistol;

    })(Kona.Weapon);
    PistolProj = (function(_super) {

      __extends(PistolProj, _super);

      function PistolProj(opts) {
        if (opts == null) {
          opts = {};
        }
        PistolProj.__super__.constructor.call(this, opts);
        this.sprite.src = 'img/weapons/bullet_1.jpg';
        this.destructibles = ['enemies'];
        this.box = {
          width: 15,
          height: 10
        };
      }

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
        this.targets = ['player'];
        this.recharge = 1000;
        this.projType = EnemyProj;
        setInterval(function() {
          return _this.fire();
        }, this.recharge);
      }

      return EnemyPistol;

    })(Kona.EnemyWeapon);
    Coin = (function(_super) {

      __extends(Coin, _super);

      function Coin() {
        return Coin.__super__.constructor.apply(this, arguments);
      }

      Coin.prototype.value = 10;

      Coin.prototype.activate = function(collector) {
        return puts("Coin activated!");
      };

      return Coin;

    })(Kona.Collectable);
    Effect = (function(_super) {

      __extends(Effect, _super);

      function Effect(opts) {
        var _this = this;
        if (opts == null) {
          opts = {};
        }
        Effect.__super__.constructor.call(this, opts);
        this.solid = false;
        this.duration = opts.duration || fail("Effect must have a duration");
        setTimeout(function() {
          return _this.destroy();
        }, this.duration);
      }

      Effect.prototype.update = function() {};

      return Effect;

    })(Kona.Entity);
    player = new Player({
      group: 'player',
      x: 200,
      y: 200,
      width: 55,
      height: 65
    });
    player.loadAnimations({
      'idle_right': {
        sheet: 'img/entities/marine_idle_right.png',
        active: true
      },
      'idle_left': {
        sheet: 'img/entities/marine_idle_left.png'
      },
      'run_right': {
        sheet: 'img/entities/marine_run_right.png'
      },
      'run_left': {
        sheet: 'img/entities/marine_run_left.png'
      }
    });
    Kona.Scenes.currentScene.addEntity(player);
    Kona.Keys.keydown = function(key) {
      switch (key) {
        case 'left':
          return player.setDirection('left');
        case 'right':
          return player.setDirection('right');
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
        entity: Kona.BlankTile
      },
      'd': {
        group: 'tiles',
        entity: Kona.Tile,
        opts: {
          sprite: 'img/tiles/dirt1.png'
        }
      },
      'l': {
        group: 'tiles',
        entity: Kona.Tile,
        opts: {
          sprite: 'img/tiles/dirt_left.png'
        }
      },
      'r': {
        group: 'tiles',
        entity: Kona.Tile,
        opts: {
          sprite: 'img/tiles/dirt_right.png'
        }
      },
      'x': {
        group: 'enemies',
        entity: Enemy,
        opts: {
          width: 45,
          height: 58,
          offset: {
            x: 5
          }
        }
      },
      'c': {
        group: 'coins',
        entity: Coin,
        opts: {
          offset: {
            x: 20,
            y: 20
          },
          sprite: 'img/powerups/coin.png'
        }
      },
      'p': {
        group: 'weapons',
        entity: Pistol,
        opts: {
          offset: {
            x: 15,
            y: 15
          },
          sprite: 'img/weapons/pistol.png'
        }
      }
    };
    Kona.Scenes.loadScenes([
      {
        background: 'img/backgrounds/lvl2.jpg',
        entities: [['-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-'], ['-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-'], ['-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-'], ['-', '-', '-', '-', '-', '-', '-', '-', '-', '-', 'l'], ['d', 'r', '-', '-', '-', '-', '-', '-', '-', 'l', 'd'], ['d', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-'], ['d', 'c', 'c', 'd', '-', '-', '-', 'd', '-', '-', '-'], ['d', 'd', 'd', 'd', 'd', '-', 'l', 'd', 'r', '-', 'r']]
      }, {
        background: 'img/backgrounds/lvl2.jpg',
        entities: [['-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-'], ['-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-'], ['-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-'], ['d', 'd', 'r', '-', '-', '-', '-', '-', '-', '-', '-'], ['-', '-', '-', '-', '-', 'l', 'd', 'r', '-', '-', '-'], ['-', '-', '-', '-', 'l', '-', '-', '-', '-', '-', '-'], ['-', '-', '-', 'l', 'd', 'c', '-', '-', '-', 'l', 'd'], ['d', 'r', '-', 'd', 'd', 'd', 'd', 'd', 'd', 'd', 'd']]
      }
    ]);
    return Kona.Engine.start();
  });

}).call(this);

