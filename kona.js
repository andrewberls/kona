// Underscore.js 1.3.3
// (c) 2009-2012 Jeremy Ashkenas, DocumentCloud Inc.
// Underscore is freely distributable under the MIT license.
// Portions of Underscore are inspired or borrowed from Prototype,
// Oliver Steele's Functional, and John Resig's Micro-Templating.
// For all details and documentation:
// http://documentcloud.github.com/underscore
(function(){function r(a,c,d){if(a===c)return 0!==a||1/a==1/c;if(null==a||null==c)return a===c;a._chain&&(a=a._wrapped);c._chain&&(c=c._wrapped);if(a.isEqual&&b.isFunction(a.isEqual))return a.isEqual(c);if(c.isEqual&&b.isFunction(c.isEqual))return c.isEqual(a);var e=l.call(a);if(e!=l.call(c))return!1;switch(e){case "[object String]":return a==""+c;case "[object Number]":return a!=+a?c!=+c:0==a?1/a==1/c:a==+c;case "[object Date]":case "[object Boolean]":return+a==+c;case "[object RegExp]":return a.source==
c.source&&a.global==c.global&&a.multiline==c.multiline&&a.ignoreCase==c.ignoreCase}if("object"!=typeof a||"object"!=typeof c)return!1;for(var f=d.length;f--;)if(d[f]==a)return!0;d.push(a);var f=0,g=!0;if("[object Array]"==e){if(f=a.length,g=f==c.length)for(;f--&&(g=f in a==f in c&&r(a[f],c[f],d)););}else{if("constructor"in a!="constructor"in c||a.constructor!=c.constructor)return!1;for(var h in a)if(b.has(a,h)&&(f++,!(g=b.has(c,h)&&r(a[h],c[h],d))))break;if(g){for(h in c)if(b.has(c,h)&&!f--)break;
g=!f}}d.pop();return g}var s=this,I=s._,o={},k=Array.prototype,p=Object.prototype,i=k.slice,J=k.unshift,l=p.toString,K=p.hasOwnProperty,y=k.forEach,z=k.map,A=k.reduce,B=k.reduceRight,C=k.filter,D=k.every,E=k.some,q=k.indexOf,F=k.lastIndexOf,p=Array.isArray,L=Object.keys,t=Function.prototype.bind,b=function(a){return new m(a)};"undefined"!==typeof exports?("undefined"!==typeof module&&module.exports&&(exports=module.exports=b),exports._=b):s._=b;b.VERSION="1.3.3";var j=b.each=b.forEach=function(a,
c,d){if(a!=null)if(y&&a.forEach===y)a.forEach(c,d);else if(a.length===+a.length)for(var e=0,f=a.length;e<f;e++){if(e in a&&c.call(d,a[e],e,a)===o)break}else for(e in a)if(b.has(a,e)&&c.call(d,a[e],e,a)===o)break};b.map=b.collect=function(a,c,b){var e=[];if(a==null)return e;if(z&&a.map===z)return a.map(c,b);j(a,function(a,g,h){e[e.length]=c.call(b,a,g,h)});if(a.length===+a.length)e.length=a.length;return e};b.reduce=b.foldl=b.inject=function(a,c,d,e){var f=arguments.length>2;a==null&&(a=[]);if(A&&
a.reduce===A){e&&(c=b.bind(c,e));return f?a.reduce(c,d):a.reduce(c)}j(a,function(a,b,i){if(f)d=c.call(e,d,a,b,i);else{d=a;f=true}});if(!f)throw new TypeError("Reduce of empty array with no initial value");return d};b.reduceRight=b.foldr=function(a,c,d,e){var f=arguments.length>2;a==null&&(a=[]);if(B&&a.reduceRight===B){e&&(c=b.bind(c,e));return f?a.reduceRight(c,d):a.reduceRight(c)}var g=b.toArray(a).reverse();e&&!f&&(c=b.bind(c,e));return f?b.reduce(g,c,d,e):b.reduce(g,c)};b.find=b.detect=function(a,
c,b){var e;G(a,function(a,g,h){if(c.call(b,a,g,h)){e=a;return true}});return e};b.filter=b.select=function(a,c,b){var e=[];if(a==null)return e;if(C&&a.filter===C)return a.filter(c,b);j(a,function(a,g,h){c.call(b,a,g,h)&&(e[e.length]=a)});return e};b.reject=function(a,c,b){var e=[];if(a==null)return e;j(a,function(a,g,h){c.call(b,a,g,h)||(e[e.length]=a)});return e};b.every=b.all=function(a,c,b){var e=true;if(a==null)return e;if(D&&a.every===D)return a.every(c,b);j(a,function(a,g,h){if(!(e=e&&c.call(b,
a,g,h)))return o});return!!e};var G=b.some=b.any=function(a,c,d){c||(c=b.identity);var e=false;if(a==null)return e;if(E&&a.some===E)return a.some(c,d);j(a,function(a,b,h){if(e||(e=c.call(d,a,b,h)))return o});return!!e};b.include=b.contains=function(a,c){var b=false;if(a==null)return b;if(q&&a.indexOf===q)return a.indexOf(c)!=-1;return b=G(a,function(a){return a===c})};b.invoke=function(a,c){var d=i.call(arguments,2);return b.map(a,function(a){return(b.isFunction(c)?c||a:a[c]).apply(a,d)})};b.pluck=
function(a,c){return b.map(a,function(a){return a[c]})};b.max=function(a,c,d){if(!c&&b.isArray(a)&&a[0]===+a[0])return Math.max.apply(Math,a);if(!c&&b.isEmpty(a))return-Infinity;var e={computed:-Infinity};j(a,function(a,b,h){b=c?c.call(d,a,b,h):a;b>=e.computed&&(e={value:a,computed:b})});return e.value};b.min=function(a,c,d){if(!c&&b.isArray(a)&&a[0]===+a[0])return Math.min.apply(Math,a);if(!c&&b.isEmpty(a))return Infinity;var e={computed:Infinity};j(a,function(a,b,h){b=c?c.call(d,a,b,h):a;b<e.computed&&
(e={value:a,computed:b})});return e.value};b.shuffle=function(a){var b=[],d;j(a,function(a,f){d=Math.floor(Math.random()*(f+1));b[f]=b[d];b[d]=a});return b};b.sortBy=function(a,c,d){var e=b.isFunction(c)?c:function(a){return a[c]};return b.pluck(b.map(a,function(a,b,c){return{value:a,criteria:e.call(d,a,b,c)}}).sort(function(a,b){var c=a.criteria,d=b.criteria;return c===void 0?1:d===void 0?-1:c<d?-1:c>d?1:0}),"value")};b.groupBy=function(a,c){var d={},e=b.isFunction(c)?c:function(a){return a[c]};
j(a,function(a,b){var c=e(a,b);(d[c]||(d[c]=[])).push(a)});return d};b.sortedIndex=function(a,c,d){d||(d=b.identity);for(var e=0,f=a.length;e<f;){var g=e+f>>1;d(a[g])<d(c)?e=g+1:f=g}return e};b.toArray=function(a){return!a?[]:b.isArray(a)||b.isArguments(a)?i.call(a):a.toArray&&b.isFunction(a.toArray)?a.toArray():b.values(a)};b.size=function(a){return b.isArray(a)?a.length:b.keys(a).length};b.first=b.head=b.take=function(a,b,d){return b!=null&&!d?i.call(a,0,b):a[0]};b.initial=function(a,b,d){return i.call(a,
0,a.length-(b==null||d?1:b))};b.last=function(a,b,d){return b!=null&&!d?i.call(a,Math.max(a.length-b,0)):a[a.length-1]};b.rest=b.tail=function(a,b,d){return i.call(a,b==null||d?1:b)};b.compact=function(a){return b.filter(a,function(a){return!!a})};b.flatten=function(a,c){return b.reduce(a,function(a,e){if(b.isArray(e))return a.concat(c?e:b.flatten(e));a[a.length]=e;return a},[])};b.without=function(a){return b.difference(a,i.call(arguments,1))};b.uniq=b.unique=function(a,c,d){var d=d?b.map(a,d):a,
e=[];a.length<3&&(c=true);b.reduce(d,function(d,g,h){if(c?b.last(d)!==g||!d.length:!b.include(d,g)){d.push(g);e.push(a[h])}return d},[]);return e};b.union=function(){return b.uniq(b.flatten(arguments,true))};b.intersection=b.intersect=function(a){var c=i.call(arguments,1);return b.filter(b.uniq(a),function(a){return b.every(c,function(c){return b.indexOf(c,a)>=0})})};b.difference=function(a){var c=b.flatten(i.call(arguments,1),true);return b.filter(a,function(a){return!b.include(c,a)})};b.zip=function(){for(var a=
i.call(arguments),c=b.max(b.pluck(a,"length")),d=Array(c),e=0;e<c;e++)d[e]=b.pluck(a,""+e);return d};b.indexOf=function(a,c,d){if(a==null)return-1;var e;if(d){d=b.sortedIndex(a,c);return a[d]===c?d:-1}if(q&&a.indexOf===q)return a.indexOf(c);d=0;for(e=a.length;d<e;d++)if(d in a&&a[d]===c)return d;return-1};b.lastIndexOf=function(a,b){if(a==null)return-1;if(F&&a.lastIndexOf===F)return a.lastIndexOf(b);for(var d=a.length;d--;)if(d in a&&a[d]===b)return d;return-1};b.range=function(a,b,d){if(arguments.length<=
1){b=a||0;a=0}for(var d=arguments[2]||1,e=Math.max(Math.ceil((b-a)/d),0),f=0,g=Array(e);f<e;){g[f++]=a;a=a+d}return g};var H=function(){};b.bind=function(a,c){var d,e;if(a.bind===t&&t)return t.apply(a,i.call(arguments,1));if(!b.isFunction(a))throw new TypeError;e=i.call(arguments,2);return d=function(){if(!(this instanceof d))return a.apply(c,e.concat(i.call(arguments)));H.prototype=a.prototype;var b=new H,g=a.apply(b,e.concat(i.call(arguments)));return Object(g)===g?g:b}};b.bindAll=function(a){var c=
i.call(arguments,1);c.length==0&&(c=b.functions(a));j(c,function(c){a[c]=b.bind(a[c],a)});return a};b.memoize=function(a,c){var d={};c||(c=b.identity);return function(){var e=c.apply(this,arguments);return b.has(d,e)?d[e]:d[e]=a.apply(this,arguments)}};b.delay=function(a,b){var d=i.call(arguments,2);return setTimeout(function(){return a.apply(null,d)},b)};b.defer=function(a){return b.delay.apply(b,[a,1].concat(i.call(arguments,1)))};b.throttle=function(a,c){var d,e,f,g,h,i,j=b.debounce(function(){h=
g=false},c);return function(){d=this;e=arguments;f||(f=setTimeout(function(){f=null;h&&a.apply(d,e);j()},c));g?h=true:i=a.apply(d,e);j();g=true;return i}};b.debounce=function(a,b,d){var e;return function(){var f=this,g=arguments;d&&!e&&a.apply(f,g);clearTimeout(e);e=setTimeout(function(){e=null;d||a.apply(f,g)},b)}};b.once=function(a){var b=false,d;return function(){if(b)return d;b=true;return d=a.apply(this,arguments)}};b.wrap=function(a,b){return function(){var d=[a].concat(i.call(arguments,0));
return b.apply(this,d)}};b.compose=function(){var a=arguments;return function(){for(var b=arguments,d=a.length-1;d>=0;d--)b=[a[d].apply(this,b)];return b[0]}};b.after=function(a,b){return a<=0?b():function(){if(--a<1)return b.apply(this,arguments)}};b.keys=L||function(a){if(a!==Object(a))throw new TypeError("Invalid object");var c=[],d;for(d in a)b.has(a,d)&&(c[c.length]=d);return c};b.values=function(a){return b.map(a,b.identity)};b.functions=b.methods=function(a){var c=[],d;for(d in a)b.isFunction(a[d])&&
c.push(d);return c.sort()};b.extend=function(a){j(i.call(arguments,1),function(b){for(var d in b)a[d]=b[d]});return a};b.pick=function(a){var c={};j(b.flatten(i.call(arguments,1)),function(b){b in a&&(c[b]=a[b])});return c};b.defaults=function(a){j(i.call(arguments,1),function(b){for(var d in b)a[d]==null&&(a[d]=b[d])});return a};b.clone=function(a){return!b.isObject(a)?a:b.isArray(a)?a.slice():b.extend({},a)};b.tap=function(a,b){b(a);return a};b.isEqual=function(a,b){return r(a,b,[])};b.isEmpty=
function(a){if(a==null)return true;if(b.isArray(a)||b.isString(a))return a.length===0;for(var c in a)if(b.has(a,c))return false;return true};b.isElement=function(a){return!!(a&&a.nodeType==1)};b.isArray=p||function(a){return l.call(a)=="[object Array]"};b.isObject=function(a){return a===Object(a)};b.isArguments=function(a){return l.call(a)=="[object Arguments]"};b.isArguments(arguments)||(b.isArguments=function(a){return!(!a||!b.has(a,"callee"))});b.isFunction=function(a){return l.call(a)=="[object Function]"};
b.isString=function(a){return l.call(a)=="[object String]"};b.isNumber=function(a){return l.call(a)=="[object Number]"};b.isFinite=function(a){return b.isNumber(a)&&isFinite(a)};b.isNaN=function(a){return a!==a};b.isBoolean=function(a){return a===true||a===false||l.call(a)=="[object Boolean]"};b.isDate=function(a){return l.call(a)=="[object Date]"};b.isRegExp=function(a){return l.call(a)=="[object RegExp]"};b.isNull=function(a){return a===null};b.isUndefined=function(a){return a===void 0};b.has=function(a,
b){return K.call(a,b)};b.noConflict=function(){s._=I;return this};b.identity=function(a){return a};b.times=function(a,b,d){for(var e=0;e<a;e++)b.call(d,e)};b.escape=function(a){return(""+a).replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;").replace(/"/g,"&quot;").replace(/'/g,"&#x27;").replace(/\//g,"&#x2F;")};b.result=function(a,c){if(a==null)return null;var d=a[c];return b.isFunction(d)?d.call(a):d};b.mixin=function(a){j(b.functions(a),function(c){M(c,b[c]=a[c])})};var N=0;b.uniqueId=
function(a){var b=N++;return a?a+b:b};b.templateSettings={evaluate:/<%([\s\S]+?)%>/g,interpolate:/<%=([\s\S]+?)%>/g,escape:/<%-([\s\S]+?)%>/g};var u=/.^/,n={"\\":"\\","'":"'",r:"\r",n:"\n",t:"\t",u2028:"\u2028",u2029:"\u2029"},v;for(v in n)n[n[v]]=v;var O=/\\|'|\r|\n|\t|\u2028|\u2029/g,P=/\\(\\|'|r|n|t|u2028|u2029)/g,w=function(a){return a.replace(P,function(a,b){return n[b]})};b.template=function(a,c,d){d=b.defaults(d||{},b.templateSettings);a="__p+='"+a.replace(O,function(a){return"\\"+n[a]}).replace(d.escape||
u,function(a,b){return"'+\n_.escape("+w(b)+")+\n'"}).replace(d.interpolate||u,function(a,b){return"'+\n("+w(b)+")+\n'"}).replace(d.evaluate||u,function(a,b){return"';\n"+w(b)+"\n;__p+='"})+"';\n";d.variable||(a="with(obj||{}){\n"+a+"}\n");var a="var __p='';var print=function(){__p+=Array.prototype.join.call(arguments, '')};\n"+a+"return __p;\n",e=new Function(d.variable||"obj","_",a);if(c)return e(c,b);c=function(a){return e.call(this,a,b)};c.source="function("+(d.variable||"obj")+"){\n"+a+"}";return c};
b.chain=function(a){return b(a).chain()};var m=function(a){this._wrapped=a};b.prototype=m.prototype;var x=function(a,c){return c?b(a).chain():a},M=function(a,c){m.prototype[a]=function(){var a=i.call(arguments);J.call(a,this._wrapped);return x(c.apply(b,a),this._chain)}};b.mixin(b);j("pop,push,reverse,shift,sort,splice,unshift".split(","),function(a){var b=k[a];m.prototype[a]=function(){var d=this._wrapped;b.apply(d,arguments);var e=d.length;(a=="shift"||a=="splice")&&e===0&&delete d[0];return x(d,
this._chain)}});j(["concat","join","slice"],function(a){var b=k[a];m.prototype[a]=function(){return x(b.apply(this._wrapped,arguments),this._chain)}});m.prototype.chain=function(){this._chain=true;return this};m.prototype.value=function(){return this._wrapped}}).call(this);

// Generated by CoffeeScript 1.3.3
var Kona,
  __hasProp = {}.hasOwnProperty;

Kona = window.Kona = {};

Kona.debugMode = true;

Kona.debug = function(obj) {
  var defined_str, is_array, is_boolean, is_number, is_object, is_string, key, log, spacer, value, _results;
  if (Kona.debugMode) {
    log = function(msg) {
      return console.log(msg);
    };
    defined_str = obj != null ? '' : '<undefined>';
    spacer = "  ";
    is_array = _.isArray(obj);
    is_string = _.isString(obj);
    is_number = _.isNumber(obj);
    is_boolean = _.isBoolean(obj);
    is_object = _.isObject(obj);
    if (obj == null) {
      log("<undefined>");
    }
    if (is_array || is_object) {
      log("Dumping " + (is_array ? 'array' : typeof obj) + ": " + defined_str);
    }
    if (is_array) {
      return log("" + spacer + "[" + obj + "]");
    } else if (is_string) {
      return log(obj);
    } else if (is_number) {
      return log(obj);
    } else if (is_boolean) {
      return log(obj.toString());
    } else if (is_object) {
      _results = [];
      for (key in obj) {
        if (!__hasProp.call(obj, key)) continue;
        value = obj[key];
        if (_.isFunction(value)) {
          _results.push(log("" + spacer + key + "(): <function>"));
        } else {
          _results.push(log("" + spacer + key + ": " + value));
        }
      }
      return _results;
    }
  }
};

Kona.readyCallbacks = [];

Kona.isReady = false;

Kona.ready = function(callback) {
  if (document.readyState === 'complete') {
    Kona.isReady = true;
  }
  if (Kona.isReady) {
    callback.call();
  }
  return Kona.readyCallbacks.push(callback);
};

Kona.DOMContentLoaded = function() {
  var callback, _i, _len, _ref, _results;
  if (Kona.isReady) {
    return;
  }
  Kona.isReady = true;
  _ref = Kona.readyCallbacks;
  _results = [];
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    callback = _ref[_i];
    _results.push(callback.call());
  }
  return _results;
};

if (document.readyState !== 'complete') {
  if (document.addEventListener) {
    document.addEventListener('DOMContentLoaded', Kona.DOMContentLoaded, false);
    window.addEventListener('load', Kona.DOMContentLoaded, false);
  } else if (document.attachEvent) {
    document.attachEvent('onreadystatechange', Kona.DOMContentLoaded);
    window.attachEvent('onload', Kona.DOMContentLoaded);
  }
}

// Generated by CoffeeScript 1.3.3

Kona.Utils = {
  printGrid: function(grid) {
    var idx, item, output, row, _i, _j, _len, _len1;
    output = "[\n";
    for (_i = 0, _len = grid.length; _i < _len; _i++) {
      row = grid[_i];
      output += "  [";
      for (idx = _j = 0, _len1 = row.length; _j < _len1; idx = ++_j) {
        item = row[idx];
        output += "" + item;
        if (idx !== row.length - 1) {
          output += ", ";
        }
      }
      output += "]\n";
    }
    return console.log("" + output + "]");
  },
  colorFor: function(num) {
    switch (num) {
      case 1:
        return 'red';
      case 2:
        return 'orange';
      case 3:
        return 'blue';
    }
  },
  randomFromTo: function(from, to) {
    return Math.floor(Math.random() * (to - from + 1) + from);
  },
  findByKey: function(list, key, value) {
    return _.find(list, function(item) {
      return item[key] === value;
    });
  }
};

// Generated by CoffeeScript 1.3.3

Kona.Canvas = {
  defaults: {
    width: 640,
    height: 480
  },
  init: function(opts) {
    if (opts == null) {
      opts = {};
    }
    this.elem = document.getElementById(opts.id) || (function() {
      throw new Error("cant build canvas with id: " + id);
    })();
    this.ctx = this.elem.getContext('2d');
    this.width = this.elem.width || this.defaults.width;
    return this.height = this.elem.height || this.defaults.height;
  },
  safe: function(fxn) {
    this.ctx.save();
    fxn();
    return this.ctx.restore();
  },
  clear: function() {
    var _this = this;
    return this.safe(function() {
      _this.ctx.fillStyle = "white";
      return _this.ctx.fillRect(0, 0, _this.width, _this.height);
    });
  },
  verticalLine: function(x) {
    var _this = this;
    return this.safe(function() {
      _this.ctx.fillStyle = 'red';
      return _this.ctx.fillRect(x, 0, 2, _this.height);
    });
  },
  highlightColumn: function(tile) {
    var _this = this;
    return Kona.Canvas.safe(function() {
      Kona.Canvas.ctx.fillStyle = 'red';
      Kona.Canvas.ctx.globalAlpha = 0.1;
      return Kona.Canvas.ctx.fillRect(tile.position.x, 0, Kona.Tile.tileSize, Kona.Canvas.height);
    });
  }
};

// Generated by CoffeeScript 1.3.3

Kona.Engine = {
  defaults: {
    fps: 24,
    width: 640,
    height: 480
  },
  start: function(opts) {
    this.fps = opts.fps || this.defaults.fps;
    Kona.Scenes.currentScene = Kona.Utils.findByKey(Kona.Scenes._scenes, 'active', true);
    return this.run();
  },
  run: function() {
    Kona.Scenes.drawCurrent();
    return requestAnimFrame(Kona.Engine.run);
  }
};

window.requestAnimFrame = (function() {
  return window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || function(callback) {
    return setTimeout(callback, 1000 / Kona.Engine.defaults.fps);
  };
})();

// Generated by CoffeeScript 1.3.3

Kona.Scenes = {
  _scenes: [],
  currentScene: {},
  drawCurrent: function() {
    return this.currentScene.draw();
  },
  setCurrent: function(sceneName) {
    this.currentScene.active = false;
    this.currentScene = Kona.Utils.findByKey(this._scenes, 'name', sceneName);
    return this.currentScene.active = true;
  }
};

Kona.Scene = (function() {

  function Scene(options) {
    if (options == null) {
      options = {};
    }
    this.active = options.active || false;
    this.name = options.name || (function() {
      throw new Error("scene must have a name");
    })();
    this.background = new Image();
    this.background.src = options.background || '';
    this.entities = [];
    Kona.Scenes._scenes.push(this);
  }

  Scene.prototype.addEntity = function(entity) {
    return this.entities.push(entity);
  };

  Scene.prototype.setLayout = function(schema) {
    var definition, entity, opts, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = schema.length; _i < _len; _i++) {
      definition = schema[_i];
      entity = definition.entity;
      _results.push((function() {
        var _j, _len1, _ref, _results1;
        _ref = definition.layout;
        _results1 = [];
        for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
          opts = _ref[_j];
          _results1.push(this.addEntity(new entity(opts)));
        }
        return _results1;
      }).call(this));
    }
    return _results;
  };

  Scene.prototype.update = function() {
    return console.log("scene update called");
  };

  Scene.prototype.draw = function() {
    var entity, _i, _len, _ref, _results;
    Kona.Canvas.clear();
    Kona.Canvas.ctx.drawImage(this.background, 0, 0);
    Kona.TileManager.draw(this.name);
    _ref = this.entities;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      entity = _ref[_i];
      entity.update();
      _results.push(entity.draw());
    }
    return _results;
  };

  return Scene;

})();

// Generated by CoffeeScript 1.3.3

Kona.Entity = (function() {

  function Entity(opts) {
    if (opts == null) {
      opts = {};
    }
    this.solid = true;
    this.position = {
      x: opts.x || 0,
      y: opts.y || 0
    };
    this.direction = {
      dx: opts.dx || 0,
      dy: opts.dy || 0
    };
    this.box = {
      width: opts.width || 0,
      height: opts.height || 0
    };
    this.sprite = new Image();
    this.sprite.src = '';
  }

  Entity.prototype.update = function() {};

  Entity.prototype.draw = function() {};

  Entity.prototype.top = function() {
    return this.position.y;
  };

  Entity.prototype.bottom = function() {
    return this.position.y + this.box.height;
  };

  Entity.prototype.left = function() {
    return this.position.x;
  };

  Entity.prototype.right = function() {
    return this.position.x + this.box.width;
  };

  Entity.prototype.futureTop = function() {
    return this.position.y + this.direction.dy;
  };

  Entity.prototype.futureBottom = function() {
    return this.bottom() + this.direction.dy;
  };

  Entity.prototype.futureLeft = function() {
    return this.position.x + this.direction.dx;
  };

  Entity.prototype.futureRight = function() {
    return this.right() + this.direction.dx;
  };

  Entity.prototype.movingLeft = function() {
    return this.direction.dx < 0;
  };

  Entity.prototype.movingRight = function() {
    return this.direction.dx > 0;
  };

  Entity.prototype.leftCollision = function() {
    var col, collision, tile, _i, _j, _len, _len1, _ref;
    collision = false;
    _ref = Kona.TileManager.columnsFor(this);
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      col = _ref[_i];
      for (_j = 0, _len1 = col.length; _j < _len1; _j++) {
        tile = col[_j];
        if (!tile.solid || this.left() > tile.right()) {
          continue;
        } else {
          if (this.right() >= tile.right() && this.futureLeft() <= tile.right()) {
            if (this.futureBottom() > tile.top() && this.futureTop() < tile.bottom()) {
              collision = true;
            }
          }
        }
      }
    }
    return collision;
  };

  Entity.prototype.rightCollision = function() {
    var col, collision, tile, _i, _j, _len, _len1, _ref;
    collision = false;
    _ref = Kona.TileManager.columnsFor(this);
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      col = _ref[_i];
      for (_j = 0, _len1 = col.length; _j < _len1; _j++) {
        tile = col[_j];
        if (!tile.solid || this.right() < tile.left()) {
          continue;
        } else {
          if (this.left() <= tile.left() && this.futureRight() >= tile.left()) {
            if (this.futureBottom() > tile.top() && this.futureTop() < tile.bottom()) {
              collision = true;
            }
          }
        }
      }
    }
    return collision;
  };

  Entity.prototype.stop = function(axis) {
    if (axis != null) {
      _.contains(['dx', 'dy'], axis) || (function() {
        throw new Error("Axis " + axis + " not recognized");
      })();
      return this.direction[axis] = 0;
    }
  };

  return Entity;

})();

// Generated by CoffeeScript 1.3.3
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Kona.TileManager = {
  sceneTilemap: {},
  tiles: [],
  buildTiles: function(scene, grid) {
    var color, row, rowBuffer, tile, x, y, _base, _i, _j, _len, _len1, _results;
    (_base = this.sceneTilemap)[scene] || (_base[scene] = []);
    x = 0;
    y = Kona.Canvas.height - (grid.length * Kona.Tile.tileSize);
    rowBuffer = [];
    _results = [];
    for (_i = 0, _len = grid.length; _i < _len; _i++) {
      row = grid[_i];
      for (_j = 0, _len1 = row.length; _j < _len1; _j++) {
        color = row[_j];
        tile = color === 0 ? new Kona.BlankTile({
          x: x,
          y: y
        }) : new Kona.Tile({
          color: color,
          x: x,
          y: y
        });
        rowBuffer.push(tile);
        x += Kona.Tile.tileSize;
      }
      x = 0;
      y += Kona.Tile.tileSize;
      this.sceneTilemap[scene].push(rowBuffer);
      _results.push(rowBuffer = []);
    }
    return _results;
  },
  draw: function(scene) {
    var row, tile, _i, _len, _ref, _results;
    _ref = this.sceneTilemap[scene];
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      row = _ref[_i];
      _results.push((function() {
        var _j, _len1, _results1;
        _results1 = [];
        for (_j = 0, _len1 = row.length; _j < _len1; _j++) {
          tile = row[_j];
          _results1.push(tile.draw());
        }
        return _results1;
      })());
    }
    return _results;
  },
  columnFor: function(idx) {
    var result, row, _i, _len, _ref;
    result = [];
    _ref = this.sceneTilemap[Kona.Scenes.currentScene.name];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      row = _ref[_i];
      result.push(row[idx]);
    }
    return result;
  },
  columnsFor: function(entity) {
    var end, grid, idx, result, start, _i;
    start = Math.floor(entity.position.x / Kona.Tile.tileSize);
    end = Math.floor((entity.position.x + entity.box.width) / Kona.Tile.tileSize);
    grid = this.sceneTilemap[Kona.Scenes.currentScene.name];
    result = [];
    for (idx = _i = start; start <= end ? _i <= end : _i >= end; idx = start <= end ? ++_i : --_i) {
      result.push(this.columnFor(idx));
    }
    return result;
  }
};

Kona.Tile = (function(_super) {

  __extends(Tile, _super);

  Tile.tileSize = 60;

  function Tile(opts) {
    Tile.__super__.constructor.call(this, opts);
    this.size = Kona.Tile.tileSize;
    this.box = {
      width: this.size,
      height: this.size
    };
    this.color = opts.color || -1;
  }

  Tile.prototype.toString = function() {
    return "<Tile @color=" + (Kona.Utils.colorFor(this.color)) + ">";
  };

  Tile.prototype.draw = function() {
    var _this = this;
    return Kona.Canvas.safe(function() {
      Kona.Canvas.ctx.fillStyle = Kona.Utils.colorFor(_this.color);
      return Kona.Canvas.ctx.fillRect(_this.position.x, _this.position.y, _this.box.width, _this.box.height);
    });
  };

  return Tile;

})(Kona.Entity);

Kona.BlankTile = (function(_super) {

  __extends(BlankTile, _super);

  function BlankTile(opts) {
    BlankTile.__super__.constructor.call(this, opts);
    this.solid = false;
    this.size = Kona.Tile.tileSize;
    this.box = {
      width: this.size,
      height: this.size
    };
  }

  BlankTile.prototype.toString = function() {
    return "<BlankTile>";
  };

  BlankTile.prototype.draw = function() {
    return Kona.Canvas.ctx.strokeRect(this.position.x, this.position.y, this.box.width, this.box.height);
  };

  return BlankTile;

})(Kona.Entity);

// Generated by CoffeeScript 1.3.3

Kona.Keys = {
  _handlers: {},
  _keycodes: {
    'enter': 13,
    'return': 13,
    'esc': 27,
    'escape': 27,
    'ctrl': 17,
    'control': 17,
    'left': 37,
    'up': 38,
    'right': 39,
    'down': 40,
    'shift': 16,
    'space': 32
  },
  _names: {
    13: 'enter',
    16: 'shift',
    17: 'ctrl',
    27: 'esc',
    32: 'space',
    37: 'left',
    38: 'up',
    39: 'right',
    40: 'down',
    48: '0',
    49: '1',
    50: '2',
    51: '3',
    52: '4',
    53: '5',
    54: '6',
    55: '7',
    56: '8',
    57: '9',
    65: 'a',
    66: 'b',
    67: 'c',
    68: 'd',
    69: 'e',
    70: 'f',
    71: 'g',
    72: 'h',
    73: 'i',
    74: 'j',
    75: 'k',
    76: 'l',
    77: 'm',
    78: 'n',
    79: 'o',
    80: 'p',
    81: 'q',
    82: 'r',
    83: 's',
    84: 't',
    85: 'u',
    86: 'v',
    87: 'w',
    88: 'x',
    89: 'y',
    90: 'z'
  },
  bind: function(key, handler) {
    var keycode, _base;
    key = key.replace(/\s/g, '');
    keycode = this._keycodes[key] || key.toUpperCase().charCodeAt(0);
    (_base = this._handlers)[keycode] || (_base[keycode] = []);
    return this._handlers[keycode].push(handler);
  },
  dispatch: function(event) {
    var handler, keycode, _i, _len, _ref, _results;
    keycode = this.eventKeyCode(event);
    if (this.reject(event) || !(this._handlers[keycode] != null)) {
      return;
    }
    _ref = this._handlers[keycode];
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      handler = _ref[_i];
      handler.call(event);
      _results.push(false);
    }
    return _results;
  },
  reject: function(event) {
    return _.contains(['INPUT', 'SELECT', 'TEXTAREA'], event.target.tagName);
  },
  keycodeName: function(event) {
    return this._names[this.eventKeyCode(event)];
  },
  eventKeyCode: function(event) {
    return event.which || event.keyCode;
  }
};

Kona.ready(function() {
  document.body.onkeydown = function(e) {
    var name;
    name = Kona.Keys.keycodeName(e);
    if (Kona.Keys.keydown) {
      return Kona.Keys.keydown(name);
    }
  };
  document.body.onkeyup = function(e) {
    var name;
    name = Kona.Keys.keycodeName(e);
    if (Kona.Keys.keyup) {
      return Kona.Keys.keyup(name);
    }
  };
  return document.addEventListener('keydown', Kona.Keys.dispatch.bind(Kona.Keys), false);
});

// Generated by CoffeeScript 1.3.3

Kona.Sound = {
  defaults: {
    autoplay: false,
    duration: 5000,
    formats: [],
    loop: false,
    placeholder: '--',
    preload: 'metadata',
    volume: 80
  },
  types: {
    'mp3': 'audio/mpeg',
    'ogg': 'audio/ogg',
    'wav': 'audio/wav',
    'aac': 'audio/aac',
    'm4a': 'audio/x-m4a'
  },
  sounds: [],
  el: document.createElement('audio'),
  all: function() {
    return new this.group(this.sounds);
  },
  isSupported: function() {
    return !!this.el.canPlayType;
  },
  isOGGSupported: function() {
    return !!this.el.canPlayType && this.el.canPlayType('audio/ogg codecs="vorbis"');
  },
  isWAVSupported: function() {
    return !!this.el.canPlayType && this.el.canPlayType('audio/wav codecs="1"');
  },
  isMP3Supported: function() {
    return !!this.el.canPlayType && this.el.canPlayType('audio/mpeg');
  },
  isAACSupported: function() {
    return !!this.el.canPlayType && (this.el.canPlayType('audio/x-m4a') || this.el.canPlayType('audio/aac'));
  },
  toTimer: function(time, withHours) {
    var clockify, h, m, s;
    clockify = function(num) {
      if (isNaN(num)) {
        return '--';
      } else if (num < 10) {
        return "0" + num;
      } else {
        return num;
      }
    };
    h = Math.floor(time / 3600);
    h = clockify(h);
    m = withHours ? Math.floor(time / 60 % 60) : Math.floor(time / 60);
    m = clockify(m);
    s = Math.floor(time % 60);
    s = clockify(s);
    return (withHours ? "" + h + ":" + m + ":" + s : "" + m + ":" + s);
  },
  fromTimer: function(time) {
    var splits;
    splits = time.toString().split(':');
    if (splits && splits.length === 3) {
      time = (parseInt(splits[0], 10) * 3600) + (parseInt(splits[1], 10) * 60) + parseInt(splits[2], 10);
    }
    if (splits && splits.length === 2) {
      time = (parseInt(splits[0], 10) * 60) + parseInt(splits[1], 10);
    }
    return time;
  },
  toPercent: function(value, total, decimal) {
    var r;
    r = Math.pow(10, decimal || 0);
    return Math.round(((value * 100) / total) * r) / r;
  },
  fromPercent: function(percent, total, decimal) {
    var r;
    r = Math.pow(10, decimal || 0);
    return Math.round(((total / 100) * percent) * r) / r;
  },
  timeRangeToArray: function(timeRange) {
    var length, num, result, _i;
    result = [];
    length = timeRange.length - 1;
    for (num = _i = 0; 0 <= length ? _i <= length : _i >= length; num = 0 <= length ? ++_i : --_i) {
      result.push({
        start: timeRange.start(length),
        end: timeRange.end(length)
      });
    }
    return result;
  },
  getExt: function(filename) {
    return filename.split('.').pop();
  },
  addSource: function(sound, src) {
    var source;
    source = document.createElement('source');
    source.src = src;
    if (Kona.Sound.types[getExt(src)] != null) {
      source.type = Kona.Sound.types[getExt(src)];
    }
    return sound.appendChild(source);
  },
  sound: function(src, options) {
    var events, eventsOnce, key, pid, s, supported, value, _i, _j, _k, _len, _len1, _len2, _ref, _ref1;
    if (options == null) {
      options = {};
    }
    pid = 0;
    events = [];
    eventsOnce = {};
    supported = Kona.Sound.isSupported();
    if (supported && src) {
      _ref = Kona.Sound.defaults;
      for (value = _i = 0, _len = _ref.length; _i < _len; value = ++_i) {
        key = _ref[value];
        options[key] = options[key] || value;
      }
      this.sound = document.createElement('audio');
      if (_.isArray(src)) {
        console.log(src);
        for (_j = 0, _len1 = src.length; _j < _len1; _j++) {
          s = src[_j];
          addSource(this.sound, s);
        }
      } else if (options.formats.length) {
        console.log(options.formats);
        _ref1 = options.formats;
        for (value = _k = 0, _len2 = _ref1.length; _k < _len2; value = ++_k) {
          key = _ref1[value];
          addSource(this.sound, "" + src + "." + key);
        }
      } else {
        addSource(this.sound, src);
      }
      if (options.loop) {
        this.loop();
      }
      if (options.autoplay) {
        this.sound.autoplay = 'autoplay';
      }
      if (options.preload === true) {
        this.sound.preload = 'auto';
      } else if (options.preload === false) {
        this.sound.preload = 'none';
      } else {
        this.sound.preload = options.preload;
      }
      this.setVolume(options.volume);
      Kona.Sound.sounds.push(this);
    }
    this.load = function() {
      return (supported ? this.sound.load() : this);
    };
    this.play = function() {
      return (supported ? this.sound.play() : this);
    };
    this.togglePlay = function() {
      if (!supported) {
        return this;
      }
      if (this.sound.paused) {
        this.sound.play();
      } else {
        this.sound.pause();
      }
      return this;
    };
    this.pause = function() {
      return (supported ? this.sound.pause() : this);
    };
    this.isPaused = function() {
      return (supported ? this.sound.paused : null);
    };
    this.stop = function() {
      if (!supported) {
        return this;
      }
      this.setTime(this.getDuration());
      this.sound.pause();
      return this;
    };
    this.isEnded = function() {
      return (supported ? this.sound.ended : null);
    };
    this.loop = function() {
      if (!supported) {
        return this;
      }
      this.sound.loop = 'loop';
      this.bind('ended.buzzloop', function() {
        this.currentTime = 0;
        return this.play();
      });
      return this;
    };
    this.unloop = function() {
      if (!supported) {
        return this;
      }
      this.sound.removeAttribute('loop');
      this.unbind('ended.buzzloop');
      return this;
    };
    this.mute = function() {
      if (!supported) {
        return this;
      }
      this.sound.muted = true;
      return this;
    };
    this.unmute = function() {
      return (supported ? this.sound.muted = false : null);
    };
    this.toggleMute = function() {
      return (supported ? this.sound.muted = !this.sound.muted : null);
    };
    this.isMuted = function() {
      return (supported ? this.sound.muted : null);
    };
    this.setVolume = function(volume) {
      if (!supported) {
        return this;
      }
      if (volume < 0) {
        volume = 0;
      }
      if (volume > 100) {
        volume = 100;
      }
      this.volume = volume;
      this.sound.volume = volume / 100;
      return this;
    };
    this.getVolume = function() {
      return (supported ? this.volume = false : null);
    };
    this.increaseVolume = function(value) {
      if (value == null) {
        value = 1;
      }
      return this.setVolume(this.volume + value);
    };
    this.decreaseVolume = function(value) {
      if (value == null) {
        value = 1;
      }
      return this.setVolume(this.volume - value);
    };
    this.setTime = function(time) {
      if (!supported) {
        return this;
      }
      return this.whenReady(function() {
        this.sound.currentTime = time;
        return this;
      });
    };
    this.getTime = function() {
      var time;
      if (!supported) {
        return null;
      }
      time = Math.round(this.sound.currentTime * 100) / 100;
      return (isNaN(time) ? buzz.defaults.placeholder : time);
    };
    this.setPercent = function(percent) {
      if (!supported) {
        return this;
      }
      return this.setTime(buzz.fromPercent(percent, this.sound.duration));
    };
    this.getPercent = function() {
      var percent;
      if (!supported) {
        return this;
      }
      percent = Math.round(buzz.toPercent(this.sound.currentTime, this.sound.duration));
      return (isNaN(percent) ? buzz.defaults.placeholder : percent);
    };
    this.setSpeed = function(duration) {
      return (supported ? this.sound.playbackRate = duration : null);
    };
    this.getSpeed = function() {
      return (supported ? this.sound.playbackRate : null);
    };
    this.getDuration = function() {
      var duration;
      if (!supported) {
        return null;
      }
      duration = Math.round(this.sound.duration * 100) / 100;
      return (isNaN(duration) ? buzz.defaults.placeholder : duration);
    };
    this.getPlayed = function() {
      return (supported ? timerangeToArray(this.sound.played) : null);
    };
    this.getBuffered = function() {
      return (supported ? timerangeToArray(this.sound.buffered) : null);
    };
    this.getSeekable = function() {
      return (supported ? timerangeToArray(this.sound.seekable) : null);
    };
    this.getErrorCode = function() {
      return (supported && this.sound.error ? this.sound.error.code : 0);
    };
    this.getErrorMessage = function() {
      if (!supported) {
        return null;
      }
      switch (this.getErrorCode) {
        case 1:
          return 'MEDIA_ERR_ABORTED';
        case 2:
          return 'MEDIA_ERR_NETWORK';
        case 3:
          return 'MEDIA_ERR_DECODE';
        case 4:
          return 'MEDIA_ERR_SRC_NOT_SUPPORTED';
        default:
          return null;
      }
    };
    this.getStateCode = function() {
      return (supported ? this.sound.readyState : null);
    };
    this.getStateMessage = function() {
      if (!supported) {
        return null;
      }
      switch (this.getStateCode) {
        case 0:
          return 'HAVE_NOTHING';
        case 1:
          return 'HAVE_METADATA';
        case 2:
          return 'HAVE_CURRENT_DATA';
        case 3:
          return 'HAVE_FUTURE_DATA';
        case 4:
          return 'HAVE_ENOUGH_DATA';
        default:
          return null;
      }
    };
    this.getNetworkStateCode = function() {
      return (supported ? this.sound.networkState : null);
    };
    this.getNetworkStateMessage = function() {
      if (!supported) {
        return null;
      }
      switch (this.getNetworkStateCode) {
        case 0:
          return 'NETWORK_EMPTY';
        case 1:
          return 'NETWORK_IDLE';
        case 2:
          return 'NETWORK_LOADING';
        case 3:
          return 'NETWORK_NO_SOURCE';
        default:
          return null;
      }
    };
    this.set = function(key, value) {
      return (supported ? this.sound[key] = value : this);
    };
    this.get = function(key) {
      if (supported) {
        return (key != null ? this.sound[key] : this.sound);
      } else {
        return null;
      }
    };
    this.bind = function(types, func) {
      var efunc, idx, self, type, _l, _len3;
      if (!supported) {
        return this;
      }
      types = types.split(' ');
      self = this;
      efunc = function(e) {
        return func.call(self, e);
      };
      for (_l = 0, _len3 = types.length; _l < _len3; _l++) {
        type = types[_l];
        idx = type;
        type = idx.split('.')[0];
        events.push({
          idx: idx,
          func: efunc
        });
        this.sound.addEventListener(type, efunc, true);
      }
      return this;
    };
    this.unbind = function(types) {
      var event, i, idx, namespace, type, _l, _len3, _len4, _m;
      if (!supported) {
        return this;
      }
      types = types.split(' ');
      for (_l = 0, _len3 = types.length; _l < _len3; _l++) {
        type = types[_l];
        idx = type;
        type = idx.split('.')[0];
        for (i = _m = 0, _len4 = events.length; _m < _len4; i = ++_m) {
          event = events[i];
          namespace = event.idx.split('.');
          if (event.idx === idx || (namespace[1] && namespace[1] === idx.replace('.', ''))) {
            this.sound.removeEventListener(type, event.func, true);
            events.splice(i, 1);
          }
        }
      }
      return this;
    };
    this.bindOnce = function(type, func) {
      var self;
      if (!supported) {
        return this;
      }
      self = this;
      eventsOnce[pid++] = false;
      return this.bind(pid + type, function() {
        if (!eventsOnce[pid]) {
          eventsOnce[pid] = true;
          func.call(self);
          return this.unbind(pid + type);
        }
      });
    };
    this.trigger = function(types) {
      var event, eventType, evt, idx, type, _l, _len3, _len4, _m;
      if (!supported) {
        return this;
      }
      types = types.split(' ');
      for (_l = 0, _len3 = types.length; _l < _len3; _l++) {
        type = types[_l];
        idx = type;
        for (_m = 0, _len4 = events.length; _m < _len4; _m++) {
          event = events[_m];
          eventType = event.idx.split('.');
          if (event.idx === idx || (eventType[0] && eventType[0] === idx.replace('.', ''))) {
            evt = document.createEvent('HTMLEvents');
            evt.initEvent(eventType[0], false, true);
            this.sound.dispatchEvent(evt);
          }
        }
      }
      return this;
    };
    this.fadeTo = function(to, duration, callback) {
      var delay, doFade, from, self;
      if (!supported) {
        return this;
      }
      if (duration instanceof Function) {
        callback = duration;
        duration = Kona.Sound.defaults.duration;
      } else {
        duration = duration || Kona.Sound.defaults.duration;
      }
      from = this.volume;
      delay = duration / Math.abs(from - to);
      self = this;
      this.play();
      doFade = function() {
        return setTimeout(function() {
          if (from < to && self.volume < to) {
            self.setVolume(self.volume += 1);
            return doFade();
          } else if (from > to && self.volume > to) {
            self.setVolume(self.volume -= 1);
            return doFade();
          } else if (callback instanceof Function) {
            return callback.apply(self);
          }
        }, delay);
      };
      this.whenReady(function() {
        return doFade();
      });
      return this;
    };
    this.fadeIn = function(duration, callback) {
      return (supported ? this.setVolume(0).fadeTo(100, duration, callback) : this);
    };
    this.fadeOut = function(duration, callback) {
      return (supported ? this.fadeTo(0, duration, callback) : this);
    };
    this.fadeWith = function(sound, duration) {
      if (!supported) {
        return this;
      }
      this.fadeOut(duration, function() {
        return this.stop();
      });
      sound.play().fadeIn(duration);
      return this;
    };
    return this.whenReady = function(func) {
      var self;
      if (!supported) {
        return null;
      }
      self = this;
      if (this.sound.readyState === 0) {
        return this.bind('canplay.buzzwhenready', function() {
          return func.call(self);
        });
      } else {
        return func.call(self);
      }
    };
  },
  group: function(sounds) {
    var argsToArray, send;
    sounds = argsToArray(sounds, arguments);
    this.getSounds = function() {
      return sounds;
    };
    this.add = function(soundArray) {
      var sound, _i, _len, _results;
      soundArray = argsToArray(soundArray, arguments);
      _results = [];
      for (_i = 0, _len = soundArray.length; _i < _len; _i++) {
        sound = soundArray[_i];
        _results.push(sounds.push(sound));
      }
      return _results;
    };
    this.load = function() {
      send('load');
      return this;
    };
    this.play = function() {
      send('play');
      return this;
    };
    this.togglePlay = function() {
      send('togglePlay');
      return this;
    };
    this.pause = function(time) {
      send('pause', time);
      return this;
    };
    this.stop = function() {
      send('stop');
      return this;
    };
    this.mute = function() {
      send('mute');
      return this;
    };
    this.unmute = function() {
      send('unmute');
      return this;
    };
    this.toggleMute = function() {
      send('toggleMute');
      return this;
    };
    this.setVolume = function(volume) {
      send('setVolume', volume);
      return this;
    };
    this.increaseVolume = function(value) {
      send('increaseVolume', value);
      return this;
    };
    this.decreaseVolume = function(value) {
      send('decreaseVolume', value);
      return this;
    };
    this.loop = function() {
      send('loop');
      return this;
    };
    this.unloop = function() {
      send('unloop');
      return this;
    };
    this.setTime = function(time) {
      send('setTime', time);
      return this;
    };
    this.setDuration = function(duration) {
      send('setDuration', duration);
      return this;
    };
    this.set = function(key, value) {
      send('set', key, value);
      return this;
    };
    this.bind = function(type, func) {
      send('bind', type, func);
      return this;
    };
    this.unbind = function(type) {
      send('unbind', type);
      return this;
    };
    this.bindOnce = function(type, func) {
      send('bindOnce', type, func);
      return this;
    };
    this.trigger = function(type) {
      send('trigger', type);
      return this;
    };
    this.fade = function(from, to, duration, callback) {
      send('fade', from, to, duration, callback);
      return this;
    };
    this.fadeIn = function(duration, callback) {
      send('fadeIn', duration, callback);
      return this;
    };
    this.fadeOut = function(duration, callback) {
      send('fadeOut', duration, callback);
      return this;
    };
    send = function() {
      var args, func, sound, _i, _len, _results;
      args = argsToArray(null, arguments);
      func = args.shift();
      _results = [];
      for (_i = 0, _len = sounds.length; _i < _len; _i++) {
        sound = sounds[_i];
        _results.push(sound[func].apply(sound, args));
      }
      return _results;
    };
    return argsToArray = function(array, args) {
      return (_.isArray(array) ? array : Array.prototype.slice.call(args));
    };
  }
};

// Generated by CoffeeScript 1.3.3
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Kona.ready(function() {
  var Shape, level, moveIncrement, shape, tiles;
  window.KUtils = Kona.Utils;
  window.KCanvas = Kona.Canvas;
  window.KEngine = Kona.Engine;
  window.KScenes = Kona.Scenes;
  window.KEntity = Kona.Entity;
  window.KTiles = Kona.TileManager;
  window.KKeys = Kona.Keys;
  window.KSound = Kona.Sound;
  Kona.beat = function() {
    return console.log("Heartbeat!");
  };
  window._k_once = 0;
  window.once = function(fxn) {
    if (window._k_once === 0) {
      fxn();
    }
    return window._k_once++;
  };
  Kona.Canvas.init({
    id: 'canvas'
  });
  level = new Kona.Scene({
    name: 'level-1',
    active: true
  });
  Shape = (function(_super) {

    __extends(Shape, _super);

    function Shape(opts) {
      this.isJumping = false;
      Shape.__super__.constructor.apply(this, arguments);
    }

    Shape.prototype.update = function() {
      var floor, grav, jumpHeight;
      floor = Kona.Canvas.height;
      jumpHeight = 12;
      grav = 5;
      if (this.futureLeft() < 0 || (this.leftCollision() && this.movingLeft())) {
        this.direction.dx = 0;
      }
      if (this.futureRight() > Kona.Engine.C_WIDTH || (this.rightCollision() && this.movingRight())) {
        this.direction.dx = 0;
      }
      this.position.x += this.direction.dx;
      if (this.isJumping) {
        return this.position.y += this.futureTop() < 0 ? 0 : -jumpHeight;
      } else if (this.bottom() < floor) {
        return this.position.y += this.bottom() + grav > floor ? floor - this.bottom() : grav;
      }
    };

    Shape.prototype.draw = function() {
      return Kona.Canvas.ctx.fillRect(this.position.x, this.position.y, this.box.width, this.box.height);
    };

    Shape.prototype.jump = function() {
      var duration,
        _this = this;
      duration = 175;
      if (this.isJumping) {
        return false;
      } else {
        this.isJumping = true;
        return setTimeout(function() {
          return _this.isJumping = false;
        }, duration);
      }
    };

    return Shape;

  })(Kona.Entity);
  shape = new Shape({
    x: 260,
    y: 200,
    width: 30,
    height: 60
  });
  level.addEntity(shape);
  moveIncrement = 3;
  Kona.Keys.keydown = function(key) {
    switch (key) {
      case 'left':
        return shape.direction.dx = -moveIncrement;
      case 'right':
        return shape.direction.dx = moveIncrement;
      case 'up':
        return shape.jump();
    }
  };
  Kona.Keys.keyup = function(key) {
    switch (key) {
      case 'left':
      case 'right':
        return shape.stop('dx');
      case 'up':
      case 'down':
        return shape.stop('dy');
    }
  };
  tiles = [[0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 1], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3], [1, 0, 2, 3, 0, 0, 1, 2, 3, 0, 2], [3, 0, 1, 2, 3, 0, 0, 1, 2, 0, 1]];
  Kona.TileManager.buildTiles('level-1', tiles);
  return Kona.Engine.start({
    id: 'canvas'
  });
});
