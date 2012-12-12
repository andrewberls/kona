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
  findByKey: function(list, key, value) {
    return _.find(list, function(item) {
      return item[key] === value;
    });
  },
  randomFromTo: function(from, to) {
    return Math.floor(Math.random() * (to - from + 1) + from);
  },
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
      default:
        return 'blank';
    }
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
      throw new Error("can't find element with id: " + id);
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
      _this.ctx.fillStyle = 'white';
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
  highlightColumn: function(x) {
    var _this = this;
    return Kona.Canvas.safe(function() {
      var left, size;
      _this.ctx.fillStyle = 'red';
      _this.ctx.globalAlpha = 0.01;
      size = Kona.Tile.tileSize;
      left = size * Math.floor(x / size);
      return Kona.Canvas.ctx.fillRect(left, 0, size, Kona.Canvas.height);
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
    if (opts == null) {
      opts = {};
    }
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

  Scene.prototype.update = function() {};

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
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Kona.Entity = (function() {

  Entity.grav = 10;

  function Entity(opts) {
    if (opts == null) {
      opts = {};
    }
    this.onSurface = __bind(this.onSurface, this);

    this.eachSolidTile = __bind(this.eachSolidTile, this);

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
    return this.top() + this.direction.dy;
  };

  Entity.prototype.futureBottom = function() {
    return this.bottom() + this.direction.dy;
  };

  Entity.prototype.futureLeft = function() {
    return this.left() + this.direction.dx;
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

  Entity.prototype.addGravity = function() {
    return this.position.y += Kona.Entity.grav;
  };

  Entity.prototype.stop = function(axis) {
    if (axis != null) {
      _.contains(['dx', 'dy'], axis) || (function() {
        throw new Error("Axis " + axis + " not recognized");
      })();
      return this.direction[axis] = 0;
    }
  };

  Entity.prototype.inRowSpace = function(e) {
    return this.futureBottom() > e.top() && this.futureTop() < e.bottom();
  };

  Entity.prototype.inColumnSpace = function(e) {
    return this.futureLeft() < e.right() && this.futureRight() > e.left();
  };

  Entity.prototype.eachSolidTile = function(fxn) {
    var col, tile, _i, _len, _ref, _results;
    _ref = Kona.TileManager.columnsFor(this);
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      col = _ref[_i];
      _results.push((function() {
        var _j, _len1, _results1;
        _results1 = [];
        for (_j = 0, _len1 = col.length; _j < _len1; _j++) {
          tile = col[_j];
          if (tile.solid) {
            _results1.push(fxn(tile));
          } else {
            _results1.push(void 0);
          }
        }
        return _results1;
      })());
    }
    return _results;
  };

  Entity.prototype.isCollision = function(checkFxn) {
    var collision,
      _this = this;
    collision = false;
    this.eachSolidTile(function(tile) {
      if (checkFxn(tile)) {
        return collision = true;
      }
    });
    return collision;
  };

  Entity.prototype.leftCollision = function() {
    var _this = this;
    return this.isCollision(function(tile) {
      return _this.right() >= tile.right() && _this.futureLeft() <= tile.right() && _this.inRowSpace(tile);
    });
  };

  Entity.prototype.rightCollision = function() {
    var _this = this;
    return this.isCollision(function(tile) {
      return _this.left() <= tile.left() && _this.futureRight() >= tile.left() && _this.inRowSpace(tile);
    });
  };

  Entity.prototype.topCollision = function() {
    var _this = this;
    return this.isCollision(function(tile) {
      return _this.bottom() >= tile.bottom() && _this.futureTop() <= tile.bottom() && _this.inColumnSpace(tile);
    });
  };

  Entity.prototype.bottomCollision = function() {
    var _this = this;
    return this.isCollision(function(tile) {
      return _this.top() <= tile.top() && _this.futureBottom() >= tile.top() && _this.inColumnSpace(tile);
    });
  };

  Entity.prototype.onSurface = function() {
    var col, tile, _i, _j, _len, _len1, _ref;
    _ref = Kona.TileManager.columnsFor(this);
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      col = _ref[_i];
      for (_j = 0, _len1 = col.length; _j < _len1; _j++) {
        tile = col[_j];
        if (tile.solid && tile.position.y === this.bottom() + 1) {
          return true;
        }
      }
    }
    return false;
  };

  Entity.prototype.correctLeft = function() {
    var _results;
    _results = [];
    while (this.leftCollision()) {
      _results.push(this.position.x += 1);
    }
    return _results;
  };

  Entity.prototype.correctRight = function() {
    var _results;
    _results = [];
    while (this.rightCollision()) {
      _results.push(this.position.x -= 1);
    }
    return _results;
  };

  Entity.prototype.correctTop = function() {
    var _results;
    _results = [];
    while (this.topCollision()) {
      _results.push(this.position.y += 1);
    }
    return _results;
  };

  Entity.prototype.correctBottom = function() {
    var _results;
    _results = [];
    while (this.bottomCollision()) {
      _results.push(this.position.y -= 1);
    }
    return _results;
  };

  return Entity;

})();

// Generated by CoffeeScript 1.3.3
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Kona.TileManager = {
  sceneTilemap: {},
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
  currentTiles: function() {
    return this.sceneTilemap[Kona.Scenes.currentScene.name];
  },
  columnFor: function(idx) {
    return _.map(this.currentTiles(), function(row) {
      return row[idx];
    });
  },
  columnsFor: function(entity) {
    var end, size, start, _i, _results,
      _this = this;
    size = Kona.Tile.tileSize;
    start = Math.floor(entity.position.x / size);
    end = Math.floor(entity.right() / size);
    return _.map((function() {
      _results = [];
      for (var _i = start; start <= end ? _i <= end : _i >= end; start <= end ? _i++ : _i--){ _results.push(_i); }
      return _results;
    }).apply(this), function(idx) {
      return _this.columnFor(idx);
    });
  }
};

Kona.Tile = (function(_super) {

  __extends(Tile, _super);

  Tile.tileSize = 60;

  function Tile(opts) {
    if (opts == null) {
      opts = {};
    }
    Tile.__super__.constructor.call(this, opts);
    this.size = Kona.Tile.tileSize;
    this.box = {
      width: this.size,
      height: this.size
    };
    this.color = opts.color || -1;
  }

  Tile.prototype.toString = function() {
    return "<Tile @x=" + this.position.x + ", @y=" + this.position.y + ", @color=" + (Kona.Utils.colorFor(this.color)) + ">";
  };

  Tile.prototype.draw = function() {
    var _this = this;
    return Kona.Canvas.safe(function() {
      Kona.Canvas.ctx.fillStyle = Kona.Utils.colorFor(_this.color);
      return Kona.Canvas.ctx.fillRect(_this.position.x, _this.position.y, _this.box.width, _this.box.height);
    });
  };

  Tile.prototype.colorName = function() {
    return Kona.Utils.colorFor(this.color);
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

})(Kona.Tile);

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

Kona.Sound = (function() {

  Sound.defaults = {
    autoplay: false,
    duration: 5000,
    formats: [],
    loop: false,
    placeholder: '--',
    preload: 'metadata',
    volume: 100
  };

  Sound.types = {
    'mp3': 'audio/mpeg',
    'ogg': 'audio/ogg',
    'wav': 'audio/wav',
    'aac': 'audio/aac',
    'm4a': 'audio/x-m4a'
  };

  Sound.sounds = [];

  Sound.testEl = document.createElement('audio');

  Sound.isSupported = function() {
    return !!this.testEl.canPlayType;
  };

  Sound.isOGGSupported = function() {
    return this.testEl.canPlayType('audio/ogg codecs="vorbis"');
  };

  Sound.isWAVSupported = function() {
    return this.testEl.canPlayType('audio/wav codecs="1"');
  };

  Sound.isMP3Supported = function() {
    return this.testEl.canPlayType('audio/mpeg codecs="mp3"');
  };

  Sound.isAACSupported = function() {
    return this.testEl.canPlayType('audio/x-m4a') || this.testEl.canPlayType('audio/aac');
  };

  Sound.supportedFormats = function() {
    var supported;
    supported = function(check) {
      if (check === '') {
        return 'yes';
      } else {
        return check;
      }
    };
    Kona.debug("Audio format compatability:");
    Kona.debug("  OGG: " + (supported(this.isOGGSupported())));
    Kona.debug("  WAV: " + (supported(this.isWAVSupported())));
    Kona.debug("  MP3: " + (supported(this.isMP3Supported())));
    return Kona.debug("  AAC: " + (supported(this.isAACSupported())));
  };

  function Sound(src, options) {
    var key, s, value, _i, _j, _len, _len1, _ref, _ref1,
      _this = this;
    if (options == null) {
      options = {};
    }
    this.supported = Kona.Sound.isSupported();
    if (this.supported && (src != null)) {
      _ref = Kona.Sound.defaults;
      for (key in _ref) {
        value = _ref[key];
        options[key] = options[key] || value;
      }
    }
    this.el = document.createElement('audio');
    if (_.isArray(src)) {
      for (_i = 0, _len = src.length; _i < _len; _i++) {
        s = src[_i];
        this.addSource(this.el, s);
      }
    } else if ((options.formats != null) && options.formats.length) {
      _ref1 = options.formats;
      for (value = _j = 0, _len1 = _ref1.length; _j < _len1; value = ++_j) {
        key = _ref1[value];
        this.addSource(this.el, "" + src + "." + key);
      }
    } else {
      this.addSource(this.el, src);
    }
    if (options.autoplay === true) {
      this.el.autoplay = 'autoplay';
    }
    if (options.preload === true) {
      this.el.preload = 'auto';
    } else if (options.preload === false) {
      this.el.preload = 'none';
    }
    this.setVolume(options.volume);
    this.el.addEventListener("loadedmetadata", function() {
      return _this.duration = _this.el.duration;
    });
    Kona.Sound.sounds.push(this);
  }

  Sound.prototype.getExt = function(filename) {
    return filename.split('.').pop();
  };

  Sound.prototype.addSource = function(el, src) {
    var ext, source;
    source = document.createElement('source');
    source.src = src;
    ext = this.getExt(src);
    if (Kona.Sound.types[ext] != null) {
      source.type = Kona.Sound.types[ext];
    }
    return el.appendChild(source);
  };

  Sound.prototype.load = function() {
    if (this.supported) {
      return this.el.load();
    } else {
      return this;
    }
  };

  Sound.prototype.play = function() {
    if (this.supported) {
      return this.el.play();
    } else {
      return this;
    }
  };

  Sound.prototype.togglePlay = function() {
    if (!this.supported) {
      return this;
    }
    if (this.el.paused) {
      this.el.play();
    } else {
      this.el.pause();
    }
    return this;
  };

  Sound.prototype.pause = function() {
    if (this.supported) {
      return this.el.pause();
    } else {
      return this;
    }
  };

  Sound.prototype.isPaused = function() {
    if (this.supported) {
      return this.el.paused;
    } else {
      return null;
    }
  };

  Sound.prototype.stop = function() {
    if (this.supported) {
      this.el.currentTime = this.el.duration;
      return this.el.pause();
    } else {
      return null;
    }
  };

  Sound.prototype.isEnded = function() {
    if (this.supported) {
      return this.el.ended;
    } else {
      return null;
    }
  };

  Sound.prototype.getDuration = function() {
    if (this.supported) {
      return this.duration;
    } else {
      return null;
    }
  };

  Sound.prototype.mute = function() {
    if (this.supported) {
      return this.el.muted = true;
    } else {
      return null;
    }
  };

  Sound.prototype.unmute = function() {
    if (this.supported) {
      return this.el.muted = false;
    } else {
      return null;
    }
  };

  Sound.prototype.isMuted = function() {
    if (this.supported) {
      return this.el.muted;
    } else {
      return null;
    }
  };

  Sound.prototype.toggleMute = function() {
    if (this.supported) {
      return this.el.muted = !this.el.muted;
    } else {
      return null;
    }
  };

  Sound.prototype.setVolume = function(volume) {
    if (!this.supported) {
      return this;
    }
    if (volume < 0) {
      volume = 0;
    }
    if (volume > 100) {
      volume = 100;
    }
    this.volume = volume;
    this.el.volume = volume / 100;
    return this;
  };

  Sound.prototype.getVolume = function() {
    if (this.supported) {
      return this.volume;
    } else {
      return null;
    }
  };

  Sound.prototype.increaseVolume = function(value) {
    if (value == null) {
      value = 1;
    }
    return this.setVolume(this.volume + value);
  };

  Sound.prototype.decreaseVolume = function(value) {
    if (value == null) {
      value = 1;
    }
    return this.setVolume(this.volume - value);
  };

  Sound.prototype.getTime = function() {
    var time;
    if (!this.supported) {
      return null;
    }
    time = Math.round(this.el.currentTime * 100) / 100;
    if (isNaN(time)) {
      return Kona.Sound.defaults.placeholder;
    } else {
      return time;
    }
  };

  Sound.prototype.getDuration = function() {
    if (this.supported) {
      return this.el.duration;
    } else {
      return null;
    }
  };

  return Sound;

})();

// Generated by CoffeeScript 1.3.3
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Kona.ready(function() {
  var Shape, level, moveIncrement, shape, tiles;
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
      if (opts == null) {
        opts = {};
      }
      this.jumpHeight = 12;
      this.isJumping = false;
      Shape.__super__.constructor.apply(this, arguments);
    }

    Shape.prototype.update = function() {
      this.position.x += this.direction.dx;
      this.correctLeft();
      this.correctRight();
      if (this.isJumping) {
        this.position.y -= this.jumpHeight;
        this.correctTop();
      } else {
        this.addGravity();
        this.correctBottom();
      }
      return Kona.Canvas.ctx.fillRect(this.position.x, this.position.y, this.box.width, this.box.height);
    };

    Shape.prototype.jump = function() {
      var duration,
        _this = this;
      duration = 175;
      if (this.isJumping) {
        return false;
      } else if (this.onSurface()) {
        this.isJumping = true;
        return setTimeout(function() {
          return _this.isJumping = false;
        }, duration);
      }
    };

    return Shape;

  })(Kona.Entity);
  shape = new Shape({
    x: 220,
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
  tiles = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 1], [1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 2], [2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3], [1, 0, 0, 2, 0, 0, 3, 2, 3, 0, 2], [3, 2, 1, 3, 1, 0, 0, 1, 2, 0, 1]];
  Kona.TileManager.buildTiles('level-1', tiles);
  return Kona.Engine.start({
    id: 'canvas'
  });
});
