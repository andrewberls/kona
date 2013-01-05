(function(){var n=this,t=n._,r={},e=Array.prototype,u=Object.prototype,i=Function.prototype,a=e.push,o=e.slice,c=e.concat,l=u.toString,f=u.hasOwnProperty,s=e.forEach,p=e.map,v=e.reduce,h=e.reduceRight,g=e.filter,d=e.every,m=e.some,y=e.indexOf,b=e.lastIndexOf,x=Array.isArray,_=Object.keys,j=i.bind,w=function(n){return n instanceof w?n:this instanceof w?(this._wrapped=n,void 0):new w(n)};"undefined"!=typeof exports?("undefined"!=typeof module&&module.exports&&(exports=module.exports=w),exports._=w):n._=w,w.VERSION="1.4.3";var A=w.each=w.forEach=function(n,t,e){if(null!=n)if(s&&n.forEach===s)n.forEach(t,e);else if(n.length===+n.length){for(var u=0,i=n.length;i>u;u++)if(t.call(e,n[u],u,n)===r)return}else for(var a in n)if(w.has(n,a)&&t.call(e,n[a],a,n)===r)return};w.map=w.collect=function(n,t,r){var e=[];return null==n?e:p&&n.map===p?n.map(t,r):(A(n,function(n,u,i){e[e.length]=t.call(r,n,u,i)}),e)};var O="Reduce of empty array with no initial value";w.reduce=w.foldl=w.inject=function(n,t,r,e){var u=arguments.length>2;if(null==n&&(n=[]),v&&n.reduce===v)return e&&(t=w.bind(t,e)),u?n.reduce(t,r):n.reduce(t);if(A(n,function(n,i,a){u?r=t.call(e,r,n,i,a):(r=n,u=!0)}),!u)throw new TypeError(O);return r},w.reduceRight=w.foldr=function(n,t,r,e){var u=arguments.length>2;if(null==n&&(n=[]),h&&n.reduceRight===h)return e&&(t=w.bind(t,e)),u?n.reduceRight(t,r):n.reduceRight(t);var i=n.length;if(i!==+i){var a=w.keys(n);i=a.length}if(A(n,function(o,c,l){c=a?a[--i]:--i,u?r=t.call(e,r,n[c],c,l):(r=n[c],u=!0)}),!u)throw new TypeError(O);return r},w.find=w.detect=function(n,t,r){var e;return E(n,function(n,u,i){return t.call(r,n,u,i)?(e=n,!0):void 0}),e},w.filter=w.select=function(n,t,r){var e=[];return null==n?e:g&&n.filter===g?n.filter(t,r):(A(n,function(n,u,i){t.call(r,n,u,i)&&(e[e.length]=n)}),e)},w.reject=function(n,t,r){return w.filter(n,function(n,e,u){return!t.call(r,n,e,u)},r)},w.every=w.all=function(n,t,e){t||(t=w.identity);var u=!0;return null==n?u:d&&n.every===d?n.every(t,e):(A(n,function(n,i,a){return(u=u&&t.call(e,n,i,a))?void 0:r}),!!u)};var E=w.some=w.any=function(n,t,e){t||(t=w.identity);var u=!1;return null==n?u:m&&n.some===m?n.some(t,e):(A(n,function(n,i,a){return u||(u=t.call(e,n,i,a))?r:void 0}),!!u)};w.contains=w.include=function(n,t){return null==n?!1:y&&n.indexOf===y?-1!=n.indexOf(t):E(n,function(n){return n===t})},w.invoke=function(n,t){var r=o.call(arguments,2);return w.map(n,function(n){return(w.isFunction(t)?t:n[t]).apply(n,r)})},w.pluck=function(n,t){return w.map(n,function(n){return n[t]})},w.where=function(n,t){return w.isEmpty(t)?[]:w.filter(n,function(n){for(var r in t)if(t[r]!==n[r])return!1;return!0})},w.max=function(n,t,r){if(!t&&w.isArray(n)&&n[0]===+n[0]&&65535>n.length)return Math.max.apply(Math,n);if(!t&&w.isEmpty(n))return-1/0;var e={computed:-1/0,value:-1/0};return A(n,function(n,u,i){var a=t?t.call(r,n,u,i):n;a>=e.computed&&(e={value:n,computed:a})}),e.value},w.min=function(n,t,r){if(!t&&w.isArray(n)&&n[0]===+n[0]&&65535>n.length)return Math.min.apply(Math,n);if(!t&&w.isEmpty(n))return 1/0;var e={computed:1/0,value:1/0};return A(n,function(n,u,i){var a=t?t.call(r,n,u,i):n;e.computed>a&&(e={value:n,computed:a})}),e.value},w.shuffle=function(n){var t,r=0,e=[];return A(n,function(n){t=w.random(r++),e[r-1]=e[t],e[t]=n}),e};var F=function(n){return w.isFunction(n)?n:function(t){return t[n]}};w.sortBy=function(n,t,r){var e=F(t);return w.pluck(w.map(n,function(n,t,u){return{value:n,index:t,criteria:e.call(r,n,t,u)}}).sort(function(n,t){var r=n.criteria,e=t.criteria;if(r!==e){if(r>e||void 0===r)return 1;if(e>r||void 0===e)return-1}return n.index<t.index?-1:1}),"value")};var k=function(n,t,r,e){var u={},i=F(t||w.identity);return A(n,function(t,a){var o=i.call(r,t,a,n);e(u,o,t)}),u};w.groupBy=function(n,t,r){return k(n,t,r,function(n,t,r){(w.has(n,t)?n[t]:n[t]=[]).push(r)})},w.countBy=function(n,t,r){return k(n,t,r,function(n,t){w.has(n,t)||(n[t]=0),n[t]++})},w.sortedIndex=function(n,t,r,e){r=null==r?w.identity:F(r);for(var u=r.call(e,t),i=0,a=n.length;a>i;){var o=i+a>>>1;u>r.call(e,n[o])?i=o+1:a=o}return i},w.toArray=function(n){return n?w.isArray(n)?o.call(n):n.length===+n.length?w.map(n,w.identity):w.values(n):[]},w.size=function(n){return null==n?0:n.length===+n.length?n.length:w.keys(n).length},w.first=w.head=w.take=function(n,t,r){return null==n?void 0:null==t||r?n[0]:o.call(n,0,t)},w.initial=function(n,t,r){return o.call(n,0,n.length-(null==t||r?1:t))},w.last=function(n,t,r){return null==n?void 0:null==t||r?n[n.length-1]:o.call(n,Math.max(n.length-t,0))},w.rest=w.tail=w.drop=function(n,t,r){return o.call(n,null==t||r?1:t)},w.compact=function(n){return w.filter(n,w.identity)};var R=function(n,t,r){return A(n,function(n){w.isArray(n)?t?a.apply(r,n):R(n,t,r):r.push(n)}),r};w.flatten=function(n,t){return R(n,t,[])},w.without=function(n){return w.difference(n,o.call(arguments,1))},w.uniq=w.unique=function(n,t,r,e){w.isFunction(t)&&(e=r,r=t,t=!1);var u=r?w.map(n,r,e):n,i=[],a=[];return A(u,function(r,e){(t?e&&a[a.length-1]===r:w.contains(a,r))||(a.push(r),i.push(n[e]))}),i},w.union=function(){return w.uniq(c.apply(e,arguments))},w.intersection=function(n){var t=o.call(arguments,1);return w.filter(w.uniq(n),function(n){return w.every(t,function(t){return w.indexOf(t,n)>=0})})},w.difference=function(n){var t=c.apply(e,o.call(arguments,1));return w.filter(n,function(n){return!w.contains(t,n)})},w.zip=function(){for(var n=o.call(arguments),t=w.max(w.pluck(n,"length")),r=Array(t),e=0;t>e;e++)r[e]=w.pluck(n,""+e);return r},w.object=function(n,t){if(null==n)return{};for(var r={},e=0,u=n.length;u>e;e++)t?r[n[e]]=t[e]:r[n[e][0]]=n[e][1];return r},w.indexOf=function(n,t,r){if(null==n)return-1;var e=0,u=n.length;if(r){if("number"!=typeof r)return e=w.sortedIndex(n,t),n[e]===t?e:-1;e=0>r?Math.max(0,u+r):r}if(y&&n.indexOf===y)return n.indexOf(t,r);for(;u>e;e++)if(n[e]===t)return e;return-1},w.lastIndexOf=function(n,t,r){if(null==n)return-1;var e=null!=r;if(b&&n.lastIndexOf===b)return e?n.lastIndexOf(t,r):n.lastIndexOf(t);for(var u=e?r:n.length;u--;)if(n[u]===t)return u;return-1},w.range=function(n,t,r){1>=arguments.length&&(t=n||0,n=0),r=arguments[2]||1;for(var e=Math.max(Math.ceil((t-n)/r),0),u=0,i=Array(e);e>u;)i[u++]=n,n+=r;return i};var I=function(){};w.bind=function(n,t){var r,e;if(n.bind===j&&j)return j.apply(n,o.call(arguments,1));if(!w.isFunction(n))throw new TypeError;return r=o.call(arguments,2),e=function(){if(!(this instanceof e))return n.apply(t,r.concat(o.call(arguments)));I.prototype=n.prototype;var u=new I;I.prototype=null;var i=n.apply(u,r.concat(o.call(arguments)));return Object(i)===i?i:u}},w.bindAll=function(n){var t=o.call(arguments,1);return 0==t.length&&(t=w.functions(n)),A(t,function(t){n[t]=w.bind(n[t],n)}),n},w.memoize=function(n,t){var r={};return t||(t=w.identity),function(){var e=t.apply(this,arguments);return w.has(r,e)?r[e]:r[e]=n.apply(this,arguments)}},w.delay=function(n,t){var r=o.call(arguments,2);return setTimeout(function(){return n.apply(null,r)},t)},w.defer=function(n){return w.delay.apply(w,[n,1].concat(o.call(arguments,1)))},w.throttle=function(n,t){var r,e,u,i,a=0,o=function(){a=new Date,u=null,i=n.apply(r,e)};return function(){var c=new Date,l=t-(c-a);return r=this,e=arguments,0>=l?(clearTimeout(u),u=null,a=c,i=n.apply(r,e)):u||(u=setTimeout(o,l)),i}},w.debounce=function(n,t,r){var e,u;return function(){var i=this,a=arguments,o=function(){e=null,r||(u=n.apply(i,a))},c=r&&!e;return clearTimeout(e),e=setTimeout(o,t),c&&(u=n.apply(i,a)),u}},w.once=function(n){var t,r=!1;return function(){return r?t:(r=!0,t=n.apply(this,arguments),n=null,t)}},w.wrap=function(n,t){return function(){var r=[n];return a.apply(r,arguments),t.apply(this,r)}},w.compose=function(){var n=arguments;return function(){for(var t=arguments,r=n.length-1;r>=0;r--)t=[n[r].apply(this,t)];return t[0]}},w.after=function(n,t){return 0>=n?t():function(){return 1>--n?t.apply(this,arguments):void 0}},w.keys=_||function(n){if(n!==Object(n))throw new TypeError("Invalid object");var t=[];for(var r in n)w.has(n,r)&&(t[t.length]=r);return t},w.values=function(n){var t=[];for(var r in n)w.has(n,r)&&t.push(n[r]);return t},w.pairs=function(n){var t=[];for(var r in n)w.has(n,r)&&t.push([r,n[r]]);return t},w.invert=function(n){var t={};for(var r in n)w.has(n,r)&&(t[n[r]]=r);return t},w.functions=w.methods=function(n){var t=[];for(var r in n)w.isFunction(n[r])&&t.push(r);return t.sort()},w.extend=function(n){return A(o.call(arguments,1),function(t){if(t)for(var r in t)n[r]=t[r]}),n},w.pick=function(n){var t={},r=c.apply(e,o.call(arguments,1));return A(r,function(r){r in n&&(t[r]=n[r])}),t},w.omit=function(n){var t={},r=c.apply(e,o.call(arguments,1));for(var u in n)w.contains(r,u)||(t[u]=n[u]);return t},w.defaults=function(n){return A(o.call(arguments,1),function(t){if(t)for(var r in t)null==n[r]&&(n[r]=t[r])}),n},w.clone=function(n){return w.isObject(n)?w.isArray(n)?n.slice():w.extend({},n):n},w.tap=function(n,t){return t(n),n};var S=function(n,t,r,e){if(n===t)return 0!==n||1/n==1/t;if(null==n||null==t)return n===t;n instanceof w&&(n=n._wrapped),t instanceof w&&(t=t._wrapped);var u=l.call(n);if(u!=l.call(t))return!1;switch(u){case"[object String]":return n==t+"";case"[object Number]":return n!=+n?t!=+t:0==n?1/n==1/t:n==+t;case"[object Date]":case"[object Boolean]":return+n==+t;case"[object RegExp]":return n.source==t.source&&n.global==t.global&&n.multiline==t.multiline&&n.ignoreCase==t.ignoreCase}if("object"!=typeof n||"object"!=typeof t)return!1;for(var i=r.length;i--;)if(r[i]==n)return e[i]==t;r.push(n),e.push(t);var a=0,o=!0;if("[object Array]"==u){if(a=n.length,o=a==t.length)for(;a--&&(o=S(n[a],t[a],r,e)););}else{var c=n.constructor,f=t.constructor;if(c!==f&&!(w.isFunction(c)&&c instanceof c&&w.isFunction(f)&&f instanceof f))return!1;for(var s in n)if(w.has(n,s)&&(a++,!(o=w.has(t,s)&&S(n[s],t[s],r,e))))break;if(o){for(s in t)if(w.has(t,s)&&!a--)break;o=!a}}return r.pop(),e.pop(),o};w.isEqual=function(n,t){return S(n,t,[],[])},w.isEmpty=function(n){if(null==n)return!0;if(w.isArray(n)||w.isString(n))return 0===n.length;for(var t in n)if(w.has(n,t))return!1;return!0},w.isElement=function(n){return!(!n||1!==n.nodeType)},w.isArray=x||function(n){return"[object Array]"==l.call(n)},w.isObject=function(n){return n===Object(n)},A(["Arguments","Function","String","Number","Date","RegExp"],function(n){w["is"+n]=function(t){return l.call(t)=="[object "+n+"]"}}),w.isArguments(arguments)||(w.isArguments=function(n){return!(!n||!w.has(n,"callee"))}),w.isFunction=function(n){return"function"==typeof n},w.isFinite=function(n){return isFinite(n)&&!isNaN(parseFloat(n))},w.isNaN=function(n){return w.isNumber(n)&&n!=+n},w.isBoolean=function(n){return n===!0||n===!1||"[object Boolean]"==l.call(n)},w.isNull=function(n){return null===n},w.isUndefined=function(n){return void 0===n},w.has=function(n,t){return f.call(n,t)},w.noConflict=function(){return n._=t,this},w.identity=function(n){return n},w.times=function(n,t,r){for(var e=Array(n),u=0;n>u;u++)e[u]=t.call(r,u);return e},w.random=function(n,t){return null==t&&(t=n,n=0),n+(0|Math.random()*(t-n+1))};var T={escape:{"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#x27;","/":"&#x2F;"}};T.unescape=w.invert(T.escape);var M={escape:RegExp("["+w.keys(T.escape).join("")+"]","g"),unescape:RegExp("("+w.keys(T.unescape).join("|")+")","g")};w.each(["escape","unescape"],function(n){w[n]=function(t){return null==t?"":(""+t).replace(M[n],function(t){return T[n][t]})}}),w.result=function(n,t){if(null==n)return null;var r=n[t];return w.isFunction(r)?r.call(n):r},w.mixin=function(n){A(w.functions(n),function(t){var r=w[t]=n[t];w.prototype[t]=function(){var n=[this._wrapped];return a.apply(n,arguments),z.call(this,r.apply(w,n))}})};var N=0;w.uniqueId=function(n){var t=""+ ++N;return n?n+t:t},w.templateSettings={evaluate:/<%([\s\S]+?)%>/g,interpolate:/<%=([\s\S]+?)%>/g,escape:/<%-([\s\S]+?)%>/g};var q=/(.)^/,B={"'":"'","\\":"\\","\r":"r","\n":"n"," ":"t","\u2028":"u2028","\u2029":"u2029"},D=/\\|'|\r|\n|\t|\u2028|\u2029/g;w.template=function(n,t,r){r=w.defaults({},r,w.templateSettings);var e=RegExp([(r.escape||q).source,(r.interpolate||q).source,(r.evaluate||q).source].join("|")+"|$","g"),u=0,i="__p+='";n.replace(e,function(t,r,e,a,o){return i+=n.slice(u,o).replace(D,function(n){return"\\"+B[n]}),r&&(i+="'+\n((__t=("+r+"))==null?'':_.escape(__t))+\n'"),e&&(i+="'+\n((__t=("+e+"))==null?'':__t)+\n'"),a&&(i+="';\n"+a+"\n__p+='"),u=o+t.length,t}),i+="';\n",r.variable||(i="with(obj||{}){\n"+i+"}\n"),i="var __t,__p='',__j=Array.prototype.join,print=function(){__p+=__j.call(arguments,'');};\n"+i+"return __p;\n";try{var a=Function(r.variable||"obj","_",i)}catch(o){throw o.source=i,o}if(t)return a(t,w);var c=function(n){return a.call(this,n,w)};return c.source="function("+(r.variable||"obj")+"){\n"+i+"}",c},w.chain=function(n){return w(n).chain()};var z=function(n){return this._chain?w(n).chain():n};w.mixin(w),A(["pop","push","reverse","shift","sort","splice","unshift"],function(n){var t=e[n];w.prototype[n]=function(){var r=this._wrapped;return t.apply(r,arguments),"shift"!=n&&"splice"!=n||0!==r.length||delete r[0],z.call(this,r)}}),A(["concat","join","slice"],function(n){var t=e[n];w.prototype[n]=function(){return z.call(this,t.apply(this._wrapped,arguments))}}),w.extend(w.prototype,{chain:function(){return this._chain=!0,this},value:function(){return this._wrapped}})}).call(this);

// Generated by CoffeeScript 1.3.3
var Kona;

Kona = window.Kona = {};

Kona.debugMode = true;

Kona.debug = function(obj) {
  if (Kona.debugMode) {
    return console.log(obj);
  }
};

window.puts = function(obj) {
  return Kona.debug(obj);
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
  find: function(list, props) {
    return _.where(list, props)[0];
  },
  merge: function(obj1, obj2) {
    var attr;
    for (attr in obj2) {
      obj1[attr] = obj2[attr];
    }
    return obj1;
  }
};

window.fail = function(msg) {
  throw new Error(msg);
};

// Generated by CoffeeScript 1.3.3

Kona.Canvas = {
  defaults: {
    width: 660,
    height: 480
  },
  init: function(id) {
    this.elem = document.getElementById(id) || fail("Can't find element with id: " + id);
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
    Kona.Scenes.currentScene = Kona.Scenes.scenes[0];
    Kona.Scenes.loadQueue();
    return this.run();
  },
  run: function() {
    requestAnimFrame(Kona.Engine.run, Kona.Canvas.elem);
    return Kona.Scenes.drawCurrent();
  }
};

window.requestAnimFrame = (function() {
  return window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || function(callback) {
    return setTimeout(callback, 1000 / Kona.Engine.defaults.fps);
  };
})();

// Generated by CoffeeScript 1.3.3

Kona.Scenes = {
  scenes: [],
  definitionMap: null,
  _queue: [],
  currentScene: {
    addEntity: function(ent) {
      return Kona.Scenes._queue.push(ent);
    }
  },
  loadQueue: function() {
    var ent, _i, _len, _ref, _results;
    _ref = this._queue;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      ent = _ref[_i];
      _results.push(this.currentScene.addEntity(ent));
    }
    return _results;
  },
  loadScenes: function(argList) {
    var args, sceneNum, _i, _len;
    if (argList == null) {
      argList = [];
    }
    sceneNum = 1;
    for (_i = 0, _len = argList.length; _i < _len; _i++) {
      args = argList[_i];
      this.scenes.push(new Kona.Scene(Kona.Utils.merge({
        name: "s" + sceneNum
      }, args)));
      sceneNum++;
    }
    return this.currentScene = this.scenes[0];
  },
  drawCurrent: function() {
    return this.currentScene.draw();
  },
  setCurrent: function(sceneName) {
    var newScene;
    this.currentScene.active = false;
    newScene = Kona.Utils.find(this.scenes, {
      name: sceneName
    }) || fail("Couldn't find scene: " + sceneName);
    this.currentScene = newScene;
    return this.currentScene.active = true;
  },
  nextScene: function() {
    var sceneNum;
    sceneNum = parseInt(this.currentScene.name.replace('s', ''));
    return this.setCurrent("s" + (++sceneNum));
  }
};

Kona.Scene = (function() {

  function Scene(opts) {
    if (opts == null) {
      opts = {};
    }
    this.active = opts.active != null ? opts.active : false;
    this.name = opts.name || fail("Scene must have a name");
    this.background = new Image();
    this.background.src = opts.background || '';
    this.entities = {};
    this.loadEntities(opts.entities);
  }

  Scene.prototype.addEntity = function(entity) {
    var group, _base;
    group = entity.group;
    (_base = this.entities)[group] || (_base[group] = []);
    return this.entities[group].push(entity);
  };

  Scene.prototype.loadEntities = function(grid) {
    var def, obj, offset, opts, row, rule, startX, startY, x, y, _i, _j, _len, _len1, _results;
    (Kona.Scenes.definitionMap != null) || fail("No definition map found");
    x = 0;
    y = Kona.Canvas.height - (grid.length * Kona.Tile.tileSize);
    _results = [];
    for (_i = 0, _len = grid.length; _i < _len; _i++) {
      row = grid[_i];
      for (_j = 0, _len1 = row.length; _j < _len1; _j++) {
        def = row[_j];
        rule = Kona.Scenes.definitionMap[def] || fail("No mapping found for rule: " + def);
        offset = rule.opts ? rule.opts.offset : null;
        startX = offset != null ? x + (offset.x || 0) : x;
        startY = offset != null ? y + (offset.y || 0) : y;
        opts = Kona.Utils.merge({
          x: startX,
          y: startY,
          group: rule.group
        }, rule.opts);
        obj = new rule.entity(opts);
        this.addEntity(obj);
        x += Kona.Tile.tileSize;
      }
      x = 0;
      _results.push(y += Kona.Tile.tileSize);
    }
    return _results;
  };

  Scene.prototype.removeEntity = function(group, entity) {
    var ent, idx, list, _i, _len, _results;
    list = this.entities[group];
    _results = [];
    for (idx = _i = 0, _len = list.length; _i < _len; idx = ++_i) {
      ent = list[idx];
      if (entity === ent) {
        _results.push(list.splice(idx, 1));
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  };

  Scene.prototype.draw = function() {
    var entity, list, name, _ref, _results;
    Kona.Canvas.clear();
    Kona.Canvas.ctx.drawImage(this.background, 0, 0);
    _ref = this.entities;
    _results = [];
    for (name in _ref) {
      list = _ref[name];
      _results.push((function() {
        var _i, _len, _results1;
        _results1 = [];
        for (_i = 0, _len = list.length; _i < _len; _i++) {
          entity = list[_i];
          if (entity != null) {
            entity.update();
            _results1.push(entity.draw());
          } else {
            _results1.push(void 0);
          }
        }
        return _results1;
      })());
    }
    return _results;
  };

  return Scene;

})();

// Generated by CoffeeScript 1.3.3
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __slice = [].slice;

Kona.Entity = (function() {

  Entity.grav = 8;

  function Entity(opts) {
    if (opts == null) {
      opts = {};
    }
    this.onSurface = __bind(this.onSurface, this);

    this.eachSolidEntity = __bind(this.eachSolidEntity, this);

    this.group = opts.group || fail("entity must have a group");
    this.solid = opts.solid || true;
    this.gravity = opts.gravity || true;
    this.speed = opts.speed || 0;
    this.facing = opts.facing || '';
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
    this.sprite.src = opts.sprite || null;
    this.animations = [];
    this.currentAnimation = null;
  }

  Entity.prototype.update = function() {
    if (this.direction.dx > 0) {
      this.facing = 'right';
    } else if (this.direction.dx < 0) {
      this.facing = 'left';
    }
    this.position.x += this.speed * this.direction.dx;
    this.position.y += this.speed * this.direction.dy;
    this.correctLeft();
    return this.correctRight();
  };

  Entity.prototype.draw = function() {
    if (this.currentAnimation != null) {
      return this.currentAnimation.draw();
    } else {
      return Kona.Canvas.ctx.drawImage(this.sprite, this.position.x, this.position.y, this.box.width, this.box.height);
    }
  };

  Entity.prototype.destroy = function() {
    return Kona.Scenes.currentScene.removeEntity(this.group, this);
  };

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

  Entity.prototype.midx = function() {
    return this.position.x + Math.ceil(this.box.width / 2);
  };

  Entity.prototype.midy = function() {
    return this.position.y + Math.ceil(this.box.height / 2);
  };

  Entity.prototype.movingLeft = function() {
    return this.direction.dx < 0;
  };

  Entity.prototype.movingRight = function() {
    return this.direction.dx > 0;
  };

  Entity.prototype.addGravity = function() {
    if (this.gravity) {
      this.position.y += Kona.Entity.grav;
      return this.correctBottom();
    }
  };

  Entity.prototype.setPosition = function(x, y) {
    this.position.x = x;
    return this.position.y = y;
  };

  Entity.prototype.stop = function(axis) {
    if (axis != null) {
      return this.direction[axis] = 0;
    } else {
      return this.direction.dx = this.direction.dy = 0;
    }
  };

  Entity.prototype.inRowSpace = function(e) {
    return this.bottom() > e.top() && this.top() < e.bottom();
  };

  Entity.prototype.inColumnSpace = function(e) {
    return this.left() < e.right() && this.right() > e.left();
  };

  Entity.prototype.neighborEntities = function() {
    var ent, list, name, neighbors, _i, _len, _ref;
    neighbors = {};
    _ref = Kona.Scenes.currentScene.entities;
    for (name in _ref) {
      list = _ref[name];
      for (_i = 0, _len = list.length; _i < _len; _i++) {
        ent = list[_i];
        neighbors[name] || (neighbors[name] = []);
        if (ent !== this) {
          neighbors[name].push(ent);
        }
      }
    }
    return neighbors;
  };

  Entity.prototype.eachSolidEntity = function(fxn) {
    var ent, list, name, _ref, _results;
    _ref = this.neighborEntities();
    _results = [];
    for (name in _ref) {
      list = _ref[name];
      _results.push((function() {
        var _i, _len, _results1;
        _results1 = [];
        for (_i = 0, _len = list.length; _i < _len; _i++) {
          ent = list[_i];
          if ((ent != null) && ent.solid) {
            _results1.push(fxn(ent));
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
    this.eachSolidEntity(function(ent) {
      if (checkFxn(ent)) {
        return collision = true;
      }
    });
    return collision;
  };

  Entity.prototype.leftCollision = function(ent) {
    return this.right() >= ent.right() && this.left() <= ent.right() && this.inRowSpace(ent);
  };

  Entity.prototype.leftCollisions = function() {
    var _this = this;
    return this.isCollision(function(ent) {
      return _this.leftCollision(ent);
    });
  };

  Entity.prototype.rightCollision = function(ent) {
    return this.left() <= ent.left() && this.right() >= ent.left() && this.inRowSpace(ent);
  };

  Entity.prototype.rightCollisions = function() {
    var _this = this;
    return this.isCollision(function(ent) {
      return _this.rightCollision(ent);
    });
  };

  Entity.prototype.topCollision = function(ent) {
    return this.bottom() >= ent.bottom() && this.top() <= ent.bottom() && this.inColumnSpace(ent);
  };

  Entity.prototype.topCollisions = function() {
    var _this = this;
    return this.isCollision(function(ent) {
      return _this.topCollision(ent);
    });
  };

  Entity.prototype.bottomCollision = function(ent) {
    return this.top() <= ent.top() && this.bottom() >= ent.top() && this.inColumnSpace(ent);
  };

  Entity.prototype.bottomCollisions = function() {
    var _this = this;
    return this.isCollision(function(ent) {
      return _this.bottomCollision(ent);
    });
  };

  Entity.prototype.intersecting = function(ent) {
    return this.leftCollision(ent) || this.rightCollision(ent) || this.topCollision(ent) || this.bottomCollision(ent);
  };

  Entity.prototype.onSurface = function() {
    var ent, list, name, _i, _len, _ref;
    _ref = this.neighborEntities();
    for (name in _ref) {
      list = _ref[name];
      for (_i = 0, _len = list.length; _i < _len; _i++) {
        ent = list[_i];
        if (ent.solid && ent.position.y === this.bottom() + 1) {
          return true;
        }
      }
    }
    return false;
  };

  Entity.prototype.correctLeft = function() {
    var _results;
    _results = [];
    while (this.leftCollisions() || this.left() < 0) {
      _results.push(this.position.x += 1);
    }
    return _results;
  };

  Entity.prototype.correctRight = function() {
    var _results;
    _results = [];
    while (this.rightCollisions()) {
      _results.push(this.position.x -= 1);
    }
    return _results;
  };

  Entity.prototype.correctTop = function() {
    var _results;
    _results = [];
    while (this.topCollisions()) {
      _results.push(this.position.y += 1);
    }
    return _results;
  };

  Entity.prototype.correctBottom = function() {
    var _results;
    _results = [];
    while (this.bottomCollisions()) {
      _results.push(this.position.y -= 1);
    }
    return _results;
  };

  Entity.prototype.collects = function() {
    var name, names, _i, _len, _results;
    names = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    _results = [];
    for (_i = 0, _len = names.length; _i < _len; _i++) {
      name = names[_i];
      _results.push(Kona.Collectors.add(name, this));
    }
    return _results;
  };

  Entity.prototype.active = function() {
    return _.contains(Kona.Scenes.currentScene.entities[this.group], this);
  };

  Entity.prototype.loadAnimations = function(animations) {
    var animOpts, name, opts, _results;
    _results = [];
    for (name in animations) {
      opts = animations[name];
      animOpts = Kona.Utils.merge({
        entity: this,
        width: this.box.width,
        height: this.box.height
      }, opts);
      this.animations[name] = new Kona.Animation(animOpts);
      if (animOpts.active === true) {
        _results.push(this.setAnimation(name));
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  };

  Entity.prototype.setAnimation = function(name) {
    return this.currentAnimation = this.animations[name] || fail("Couldn't find animation with name " + name);
  };

  Entity.prototype.clearAnimation = function() {
    return this.currentAnimation = null;
  };

  return Entity;

})();

// Generated by CoffeeScript 1.3.3

Kona.Animation = (function() {

  function Animation(opts) {
    if (opts == null) {
      opts = {};
    }
    this.lastUpdateTime = 0;
    this.elapsed = 0;
    this.msPerFrame = opts.msPerFrame || 25;
    this.entity = opts.entity;
    this.image = new Image();
    this.image.src = opts.sheet;
    this.position = {
      x: 0,
      y: 0
    };
    this.frames = {
      width: opts.width,
      height: opts.height
    };
    this.repeat = opts.repeat != null ? opts.repeat : true;
    this.next = opts.next || null;
    this.played = false;
  }

  Animation.prototype.triggerNext = function() {
    if (_.isString(this.next)) {
      return this.entity.setAnimation(this.next);
    } else if (_.isFunction(this.next)) {
      return this.next();
    }
  };

  Animation.prototype.update = function() {
    var delta;
    delta = Date.now() - this.lastUpdateTime;
    if (this.elapsed > this.msPerFrame) {
      this.elapsed = 0;
      this.position.x += this.frames.width;
      if (this.position.x + this.frames.width > this.image.width) {
        if (this.position.y + this.frames.height >= this.image.height) {
          this.played = true;
          this.triggerNext();
          this.position.x = this.position.y = 0;
        } else {
          this.position.x = 0;
          this.position.y += this.frames.height;
        }
      }
    } else {
      this.elapsed += delta;
    }
    return this.lastUpdateTime = Date.now();
  };

  Animation.prototype.draw = function() {
    var targetHeight, targetWidth, targetX, targetY;
    targetX = this.entity.position.x;
    targetY = this.entity.position.y;
    targetWidth = this.entity.box.width;
    targetHeight = this.entity.box.height;
    if (!(!this.repeat && this.played)) {
      Kona.Canvas.ctx.drawImage(this.image, this.position.x, this.position.y, this.frames.width, this.frames.height, targetX, targetY, targetWidth, targetHeight);
      return this.update();
    }
  };

  return Animation;

})();

// Generated by CoffeeScript 1.3.3
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

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
  }

  Tile.prototype.update = function() {};

  return Tile;

})(Kona.Entity);

Kona.BlankTile = (function(_super) {

  __extends(BlankTile, _super);

  function BlankTile(opts) {
    BlankTile.__super__.constructor.call(this, opts);
    this.solid = false;
  }

  BlankTile.prototype.update = function() {};

  BlankTile.prototype.draw = function() {};

  return BlankTile;

})(Kona.Tile);

// Generated by CoffeeScript 1.3.3
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Kona.Collectable = (function(_super) {

  __extends(Collectable, _super);

  function Collectable(opts) {
    if (opts == null) {
      opts = {};
    }
    Collectable.__super__.constructor.call(this, opts);
    this.solid = false;
    this.gravity = false;
  }

  Collectable.prototype.update = function() {
    var collectors, entity, _i, _len, _results;
    collectors = Kona.Collectors[this.group];
    if (collectors != null) {
      _results = [];
      for (_i = 0, _len = collectors.length; _i < _len; _i++) {
        entity = collectors[_i];
        if (this.intersecting(entity)) {
          this.activate(entity);
          _results.push(this.destroy());
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    }
  };

  Collectable.prototype.activate = function() {
    return fail("Implement activate() in a derived Collectable class");
  };

  return Collectable;

})(Kona.Entity);

Kona.Collectors = {
  add: function(group, entity) {
    this[group] || (this[group] = []);
    return this[group].push(entity);
  }
};

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

Kona.Sounds = {
  sounds: {},
  load: function(sounds) {
    var name, src, _results;
    if (sounds == null) {
      sounds = {};
    }
    _results = [];
    for (name in sounds) {
      src = sounds[name];
      _results.push(this.sounds[name] = new Kona.Sound(src));
    }
    return _results;
  },
  play: function(name) {
    return this.sounds[name].play();
  }
};

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

  function Sound(src, opts) {
    var key, s, value, _i, _j, _len, _len1, _ref, _ref1,
      _this = this;
    if (opts == null) {
      opts = {};
    }
    this.supported = Kona.Sound.isSupported();
    if (this.supported && (src != null)) {
      _ref = Kona.Sound.defaults;
      for (key in _ref) {
        value = _ref[key];
        opts[key] = opts[key] || value;
      }
    }
    this.el = document.createElement('audio');
    if (_.isArray(src)) {
      for (_i = 0, _len = src.length; _i < _len; _i++) {
        s = src[_i];
        this.addSource(this.el, s);
      }
    } else if ((opts.formats != null) && opts.formats.length) {
      _ref1 = opts.formats;
      for (value = _j = 0, _len1 = _ref1.length; _j < _len1; value = ++_j) {
        key = _ref1[value];
        this.addSource(this.el, "" + src + "." + key);
      }
    } else {
      this.addSource(this.el, src);
    }
    if (opts.autoplay === true) {
      this.el.autoplay = 'autoplay';
    }
    this.el.preload = opts.preload === true ? 'auto' : 'none';
    this.setVolume(opts.volume);
    this.el.addEventListener("loadedmetadata", function() {
      return _this.duration = _this.el.duration;
    });
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

Kona.Menu = (function(_super) {

  __extends(Menu, _super);

  function Menu(opts) {
    var _this = this;
    if (opts == null) {
      opts = {};
    }
    Menu.__super__.constructor.call(this, opts);
    puts("constructing menu");
    this.fontSize = opts.fontSize || '30px';
    this.font = opts.font || 'Helvetica';
    this.textAlign = opts.textAlign || 'center';
    this.textColor = opts.textColor || 'white';
    this.selectedColor = opts.selectedColor || 'yellow';
    this.options = opts.options;
    this.trigger = opts.trigger;
    if (this.trigger != null) {
      Kona.Keys.bind(this.trigger, function() {
        Kona.Canvas.clear();
        return Kona.Scenes.setCurrent(_this.name);
      });
    }
  }

  Menu.prototype.draw = function() {
    var _this = this;
    return Kona.Canvas.safe(function() {
      var callback, text, y, y_offset, _ref, _results;
      Kona.Canvas.ctx.font = "" + _this.fontSize + " " + _this.font;
      Kona.Canvas.ctx.textAlign = _this.textAlign;
      y = (Kona.Canvas.height - (parseInt(_this.fontSize) * _.size(_this.options))) / 2;
      y_offset = 0;
      _ref = _this.options;
      _results = [];
      for (text in _ref) {
        callback = _ref[text];
        Kona.Canvas.ctx.fillStyle = 'red';
        Kona.Canvas.ctx.fillText(text, Kona.Canvas.width / 2, y + y_offset);
        _results.push(y_offset += parseInt(_this.fontSize) + 20);
      }
      return _results;
    });
  };

  return Menu;

})(Kona.Scene);

// Generated by CoffeeScript 1.3.3
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Kona.Weapon = (function(_super) {

  __extends(Weapon, _super);

  function Weapon(opts) {
    if (opts == null) {
      opts = {};
    }
    Weapon.__super__.constructor.call(this, opts);
    this.canFire = true;
    this.recharge = opts.recharge || 150;
    this.projType = opts.projType || null;
    this.projSound = opts.sound || '';
    this.holder = opts.holder || null;
  }

  Weapon.prototype.activate = function(collector) {
    this.holder = collector;
    return collector.currentWeapon = this;
  };

  Weapon.prototype.fire = function() {
    var proj, projDx, startX, startY,
      _this = this;
    if (this.canFire) {
      projDx = this.holder.facing === 'right' ? 1 : -1;
      startX = this.holder.facing === 'right' ? this.holder.right() + 1 : this.holder.left() - 30;
      startY = this.holder.top() + 15;
      proj = new this.projType({
        group: 'projectiles',
        x: startX,
        y: startY,
        dx: projDx
      });
      Kona.Scenes.currentScene.addEntity(proj);
      if (this.projSound !== '') {
        Kona.Sounds.play(this.projSound);
      }
      this.canFire = false;
      return setTimeout(function() {
        return _this.canFire = true;
      }, this.recharge);
    }
  };

  return Weapon;

})(Kona.Collectable);

Kona.EnemyWeapon = (function(_super) {

  __extends(EnemyWeapon, _super);

  function EnemyWeapon() {
    return EnemyWeapon.__super__.constructor.apply(this, arguments);
  }

  EnemyWeapon.prototype.randomTarget = function() {
    var group, targetEnts, _i, _len, _ref;
    targetEnts = [];
    _ref = this.targets;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      group = _ref[_i];
      targetEnts = targetEnts.concat(Kona.Scenes.currentScene.entities[group]);
    }
    return _.shuffle(targetEnts)[0];
  };

  EnemyWeapon.prototype.fire = function() {
    var angle, proj, projDx, projDy, speed, startX, startY, target, targetLeft, targetUp, x, y;
    target = this.randomTarget();
    if (this.holder.active()) {
      x = Math.abs(this.holder.midx() - target.midx());
      y = Math.abs(this.holder.midy() - target.midy());
      targetLeft = this.holder.position.x >= target.midx();
      targetUp = this.holder.position.y >= target.midy();
      angle = Math.atan2(y, x) + (targetUp ? 0.5 : 0);
      speed = 1;
      projDx = speed * Math.cos(angle) * (targetLeft ? -1 : 1);
      projDy = speed * Math.sin(angle) * (targetUp ? -1 : 1);
      startX = targetLeft ? this.holder.left() - 20 : this.holder.right() + 20;
      startY = this.holder.top() + 25;
      proj = new this.projType({
        group: 'projectiles',
        x: startX,
        y: startY,
        dx: projDx,
        dy: projDy
      });
      Kona.Scenes.currentScene.addEntity(proj);
      if (this.projSound !== '') {
        return Kona.Sounds.play(this.projSound);
      }
    }
  };

  return EnemyWeapon;

})(Kona.Weapon);

// Generated by CoffeeScript 1.3.3
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Kona.Projectile = (function(_super) {

  __extends(Projectile, _super);

  function Projectile(opts) {
    if (opts == null) {
      opts = {};
    }
    Projectile.__super__.constructor.call(this, opts);
    this.speed = 7;
  }

  Projectile.prototype.update = function() {
    var ent, list, name, _i, _len, _ref;
    Projectile.__super__.update.apply(this, arguments);
    this.position.x += this.speed * this.direction.dx;
    if (this.leftCollisions() || this.rightCollisions()) {
      _ref = this.neighborEntities();
      for (name in _ref) {
        list = _ref[name];
        for (_i = 0, _len = list.length; _i < _len; _i++) {
          ent = list[_i];
          if (this.leftCollision(ent) || this.rightCollision(ent)) {
            if (_.contains(this.destructibles, name)) {
              ent.destroy();
            }
            this.destroy();
          }
        }
      }
    }
    if (this.position.x < 0 || this.position.x > Kona.Canvas.width) {
      return this.destroy();
    }
  };

  return Projectile;

})(Kona.Entity);
