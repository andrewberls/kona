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

// ----------------------------------------------------------------------------
// Buzz, a Javascript HTML5 Audio library
// v 1.0.x beta
// Licensed under the MIT license.
// http://buzz.jaysalvat.com/
// ----------------------------------------------------------------------------
// Copyright (C) 2011 Jay Salvat
// http://jaysalvat.com/
// ----------------------------------------------------------------------------
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files ( the "Software" ), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
// ----------------------------------------------------------------------------

var buzz = {
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
    el: document.createElement( 'audio' ),

    sound: function( src, options ) {
        options = options || {};

        var pid = 0,
            events = [],
            eventsOnce = {},
            supported = buzz.isSupported();

        // publics
        this.load = function() {
            if ( !supported ) {
              return this;
            }

            this.sound.load();
            return this;
        };

        this.play = function() {
            if ( !supported ) {
              return this;
            }

            this.sound.play();
            return this;
        };

        this.togglePlay = function() {
            if ( !supported ) {
              return this;
            }

            if ( this.sound.paused ) {
                this.sound.play();
            } else {
                this.sound.pause();
            }
            return this;
        };

        this.pause = function() {
            if ( !supported ) {
              return this;
            }

            this.sound.pause();
            return this;
        };

        this.isPaused = function() {
            if ( !supported ) {
              return null;
            }

            return this.sound.paused;
        };

        this.stop = function() {
            if ( !supported  ) {
              return this;
            }

            this.setTime( this.getDuration() );
            this.sound.pause();
            return this;
        };

        this.isEnded = function() {
            if ( !supported ) {
              return null;
            }

            return this.sound.ended;
        };

        this.loop = function() {
            if ( !supported ) {
              return this;
            }

            this.sound.loop = 'loop';
            this.bind( 'ended.buzzloop', function() {
                this.currentTime = 0;
                this.play();
            });
            return this;
        };

        this.unloop = function() {
            if ( !supported ) {
              return this;
            }

            this.sound.removeAttribute( 'loop' );
            this.unbind( 'ended.buzzloop' );
            return this;
        };

        this.mute = function() {
            if ( !supported ) {
              return this;
            }

            this.sound.muted = true;
            return this;
        };

        this.unmute = function() {
            if ( !supported ) {
              return this;
            }

            this.sound.muted = false;
            return this;
        };

        this.toggleMute = function() {
            if ( !supported ) {
              return this;
            }

            this.sound.muted = !this.sound.muted;
            return this;
        };

        this.isMuted = function() {
            if ( !supported ) {
              return null;
            }

            return this.sound.muted;
        };

        this.setVolume = function( volume ) {
            if ( !supported ) {
              return this;
            }

            if ( volume < 0 ) {
              volume = 0;
            }
            if ( volume > 100 ) {
              volume = 100;
            }
          
            this.volume = volume;
            this.sound.volume = volume / 100;
            return this;
        };
      
        this.getVolume = function() {
            if ( !supported ) {
              return this;
            }

            return this.volume;
        };

        this.increaseVolume = function( value ) {
            return this.setVolume( this.volume + ( value || 1 ) );
        };

        this.decreaseVolume = function( value ) {
            return this.setVolume( this.volume - ( value || 1 ) );
        };

        this.setTime = function( time ) {
            if ( !supported ) {
              return this;
            }

            this.whenReady( function() {
                this.sound.currentTime = time;
            });
            return this;
        };

        this.getTime = function() {
            if ( !supported ) {
              return null;
            }

            var time = Math.round( this.sound.currentTime * 100 ) / 100;
            return isNaN( time ) ? buzz.defaults.placeholder : time;
        };

        this.setPercent = function( percent ) {
            if ( !supported ) {
              return this;
            }

            return this.setTime( buzz.fromPercent( percent, this.sound.duration ) );
        };

        this.getPercent = function() {
            if ( !supported ) {
              return null;
            }

			var percent = Math.round( buzz.toPercent( this.sound.currentTime, this.sound.duration ) );
            return isNaN( percent ) ? buzz.defaults.placeholder : percent;
        };

        this.setSpeed = function( duration ) {
			if ( !supported ) {
              return this;
            }

            this.sound.playbackRate = duration;
        };

        this.getSpeed = function() {
			if ( !supported ) {
              return null;
            }

            return this.sound.playbackRate;
        };

        this.getDuration = function() {
            if ( !supported ) {
              return null;
            }

            var duration = Math.round( this.sound.duration * 100 ) / 100;
            return isNaN( duration ) ? buzz.defaults.placeholder : duration;
        };

        this.getPlayed = function() {
			if ( !supported ) {
              return null;
            }

            return timerangeToArray( this.sound.played );
        };

        this.getBuffered = function() {
			if ( !supported ) {
              return null;
            }

            return timerangeToArray( this.sound.buffered );
        };

        this.getSeekable = function() {
			if ( !supported ) {
              return null;
            }

            return timerangeToArray( this.sound.seekable );
        };

        this.getErrorCode = function() {
            if ( supported && this.sound.error ) {
                return this.sound.error.code;
            }
            return 0;
        };

        this.getErrorMessage = function() {
			if ( !supported ) {
              return null;
            }

            switch( this.getErrorCode() ) {
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
			if ( !supported ) {
              return null;
            }

            return this.sound.readyState;
        };

        this.getStateMessage = function() {
			if ( !supported ) {
              return null;
            }

            switch( this.getStateCode() ) {
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
			if ( !supported ) {
              return null;
            }

            return this.sound.networkState;
        };

        this.getNetworkStateMessage = function() {
			if ( !supported ) {
              return null;
            }

            switch( this.getNetworkStateCode() ) {
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

        this.set = function( key, value ) {
            if ( !supported ) {
              return this;
            }

            this.sound[ key ] = value;
            return this;
        };

        this.get = function( key ) {
            if ( !supported ) {
              return null;
            }

            return key ? this.sound[ key ] : this.sound;
        };

        this.bind = function( types, func ) {
            if ( !supported ) {
              return this;
            }

            types = types.split( ' ' );

            var that = this,
				efunc = function( e ) { func.call( that, e ); };

            for( var t = 0; t < types.length; t++ ) {
                var type = types[ t ],
                    idx = type;
                    type = idx.split( '.' )[ 0 ];

                    events.push( { idx: idx, func: efunc } );
                    this.sound.addEventListener( type, efunc, true );
            }
            return this;
        };

        this.unbind = function( types ) {
            if ( !supported ) {
              return this;
            }

            types = types.split( ' ' );

            for( var t = 0; t < types.length; t++ ) {
                var idx = types[ t ],
                    type = idx.split( '.' )[ 0 ];

                for( var i = 0; i < events.length; i++ ) {
                    var namespace = events[ i ].idx.split( '.' );
                    if ( events[ i ].idx == idx || ( namespace[ 1 ] && namespace[ 1 ] == idx.replace( '.', '' ) ) ) {
                        this.sound.removeEventListener( type, events[ i ].func, true );
                        // remove event
                        events.splice(i, 1);
                    }
                }
            }
            return this;
        };

        this.bindOnce = function( type, func ) {
            if ( !supported ) {
              return this;
            }

            var that = this;

            eventsOnce[ pid++ ] = false;
            this.bind( pid + type, function() {
               if ( !eventsOnce[ pid ] ) {
                   eventsOnce[ pid ] = true;
                   func.call( that );
               }
               that.unbind( pid + type );
            });
        };

        this.trigger = function( types ) {
            if ( !supported ) {
              return this;
            }

            types = types.split( ' ' );

            for( var t = 0; t < types.length; t++ ) {
                var idx = types[ t ];

                for( var i = 0; i < events.length; i++ ) {
                    var eventType = events[ i ].idx.split( '.' );
                    if ( events[ i ].idx == idx || ( eventType[ 0 ] && eventType[ 0 ] == idx.replace( '.', '' ) ) ) {
                        var evt = document.createEvent('HTMLEvents');
                        evt.initEvent( eventType[ 0 ], false, true );
                        this.sound.dispatchEvent( evt );
                    }
                }
            }
            return this;
        };

        this.fadeTo = function( to, duration, callback ) {
			if ( !supported ) {
              return this;
            }

            if ( duration instanceof Function ) {
                callback = duration;
                duration = buzz.defaults.duration;
            } else {
                duration = duration || buzz.defaults.duration;
            }

            var from = this.volume,
				delay = duration / Math.abs( from - to ),
                that = this;
            this.play();

            function doFade() {
                setTimeout( function() {
                    if ( from < to && that.volume < to ) {
                        that.setVolume( that.volume += 1 );
                        doFade();
                    } else if ( from > to && that.volume > to ) {
                        that.setVolume( that.volume -= 1 );
                        doFade();
                    } else if ( callback instanceof Function ) {
                        callback.apply( that );
                    }
                }, delay );
            }
            this.whenReady( function() {
                doFade();
            });

            return this;
        };

        this.fadeIn = function( duration, callback ) {
            if ( !supported ) {
              return this;
            }

            return this.setVolume(0).fadeTo( 100, duration, callback );
        };

        this.fadeOut = function( duration, callback ) {
			if ( !supported ) {
              return this;
            }

            return this.fadeTo( 0, duration, callback );
        };

        this.fadeWith = function( sound, duration ) {
            if ( !supported ) {
              return this;
            }

            this.fadeOut( duration, function() {
                this.stop();
            });

            sound.play().fadeIn( duration );

            return this;
        };

        this.whenReady = function( func ) {
            if ( !supported ) {
              return null;
            }

            var that = this;
            if ( this.sound.readyState === 0 ) {
                this.bind( 'canplay.buzzwhenready', function() {
                    func.call( that );
                });
            } else {
                func.call( that );
            }
        };

        // privates
        function timerangeToArray( timeRange ) {
            var array = [],
                length = timeRange.length - 1;

            for( var i = 0; i <= length; i++ ) {
                array.push({
                    start: timeRange.start( length ),
                    end: timeRange.end( length )
                });
            }
            return array;
        }

        function getExt( filename ) {
            return filename.split('.').pop();
        }
        
        function addSource( sound, src ) {
            var source = document.createElement( 'source' );
            source.src = src;
            if ( buzz.types[ getExt( src ) ] ) {
                source.type = buzz.types[ getExt( src ) ];
            }
            sound.appendChild( source );
        }

        // init
        if ( supported && src ) {
          
            for(var i in buzz.defaults ) {
              if(buzz.defaults.hasOwnProperty(i)) {
                options[ i ] = options[ i ] || buzz.defaults[ i ];
              }
            }

            this.sound = document.createElement( 'audio' );

            if ( src instanceof Array ) {
                for( var j in src ) {
                  if(src.hasOwnProperty(j)) {
                    addSource( this.sound, src[ j ] );
                  }
                }
            } else if ( options.formats.length ) {
                for( var k in options.formats ) {
                  if(options.formats.hasOwnProperty(k)) {
                    addSource( this.sound, src + '.' + options.formats[ k ] );
                  }
                }
            } else {
                addSource( this.sound, src );
            }

            if ( options.loop ) {
                this.loop();
            }

            if ( options.autoplay ) {
                this.sound.autoplay = 'autoplay';
            }

            if ( options.preload === true ) {
                this.sound.preload = 'auto';
            } else if ( options.preload === false ) {
                this.sound.preload = 'none';
            } else {
                this.sound.preload = options.preload;
            }

            this.setVolume( options.volume );

            buzz.sounds.push( this );
        }
    },

    group: function( sounds ) {
        sounds = argsToArray( sounds, arguments );

        // publics
        this.getSounds = function() {
            return sounds;
        };

        this.add = function( soundArray ) {
            soundArray = argsToArray( soundArray, arguments );
            for( var a = 0; a < soundArray.length; a++ ) {
                sounds.push( soundArray[ a ] );
            }
        };

        this.remove = function( soundArray ) {
            soundArray = argsToArray( soundArray, arguments );
            for( var a = 0; a < soundArray.length; a++ ) {
                for( var i = 0; i < sounds.length; i++ ) {
                    if ( sounds[ i ] == soundArray[ a ] ) {
                        delete sounds[ i ];
                        break;
                    }
                }
            }
        };

        this.load = function() {
            fn( 'load' );
            return this;
        };

        this.play = function() {
            fn( 'play' );
            return this;
        };

        this.togglePlay = function( ) {
            fn( 'togglePlay' );
            return this;
        };

        this.pause = function( time ) {
            fn( 'pause', time );
            return this;
        };

        this.stop = function() {
            fn( 'stop' );
            return this;
        };

        this.mute = function() {
            fn( 'mute' );
            return this;
        };

        this.unmute = function() {
            fn( 'unmute' );
            return this;
        };

        this.toggleMute = function() {
            fn( 'toggleMute' );
            return this;
        };

        this.setVolume = function( volume ) {
            fn( 'setVolume', volume );
            return this;
        };

        this.increaseVolume = function( value ) {
            fn( 'increaseVolume', value );
            return this;
        };

        this.decreaseVolume = function( value ) {
            fn( 'decreaseVolume', value );
            return this;
        };

        this.loop = function() {
            fn( 'loop' );
            return this;
        };

        this.unloop = function() {
            fn( 'unloop' );
            return this;
        };

        this.setTime = function( time ) {
            fn( 'setTime', time );
            return this;
        };

        this.setduration = function( duration ) {
            fn( 'setduration', duration );
            return this;
        };

        this.set = function( key, value ) {
            fn( 'set', key, value );
            return this;
        };

        this.bind = function( type, func ) {
            fn( 'bind', type, func );
            return this;
        };

        this.unbind = function( type ) {
            fn( 'unbind', type );
            return this;
        };

        this.bindOnce = function( type, func ) {
            fn( 'bindOnce', type, func );
            return this;
        };

        this.trigger = function( type ) {
            fn( 'trigger', type );
            return this;
        };

        this.fade = function( from, to, duration, callback ) {
            fn( 'fade', from, to, duration, callback );
            return this;
        };

        this.fadeIn = function( duration, callback ) {
            fn( 'fadeIn', duration, callback );
            return this;
        };

        this.fadeOut = function( duration, callback ) {
            fn( 'fadeOut', duration, callback );
            return this;
        };

        // privates
        function fn() {
            var args = argsToArray( null, arguments ),
                func = args.shift();

            for( var i = 0; i < sounds.length; i++ ) {
                sounds[ i ][ func ].apply( sounds[ i ], args );
            }
        }

        function argsToArray( array, args ) {
            return ( array instanceof Array ) ? array : Array.prototype.slice.call( args );
        }
    },

    all: function() {
      return new buzz.group( buzz.sounds );
    },

    isSupported: function() {
        return !!buzz.el.canPlayType;
    },

    isOGGSupported: function() {
        return !!buzz.el.canPlayType && buzz.el.canPlayType( 'audio/ogg; codecs="vorbis"' );
    },

    isWAVSupported: function() {
        return !!buzz.el.canPlayType && buzz.el.canPlayType( 'audio/wav; codecs="1"' );
    },

    isMP3Supported: function() {
        return !!buzz.el.canPlayType && buzz.el.canPlayType( 'audio/mpeg;' );
    },

    isAACSupported: function() {
        return !!buzz.el.canPlayType && ( buzz.el.canPlayType( 'audio/x-m4a;' ) || buzz.el.canPlayType( 'audio/aac;' ) );
    },

    toTimer: function( time, withHours ) {
        var h, m, s;
        h = Math.floor( time / 3600 );
        h = isNaN( h ) ? '--' : ( h >= 10 ) ? h : '0' + h;
        m = withHours ? Math.floor( time / 60 % 60 ) : Math.floor( time / 60 );
        m = isNaN( m ) ? '--' : ( m >= 10 ) ? m : '0' + m;
        s = Math.floor( time % 60 );
        s = isNaN( s ) ? '--' : ( s >= 10 ) ? s : '0' + s;
        return withHours ? h + ':' + m + ':' + s : m + ':' + s;
    },

    fromTimer: function( time ) {
        var splits = time.toString().split( ':' );
        if ( splits && splits.length == 3 ) {
            time = ( parseInt( splits[ 0 ], 10 ) * 3600 ) + ( parseInt(splits[ 1 ], 10 ) * 60 ) + parseInt( splits[ 2 ], 10 );
        }
        if ( splits && splits.length == 2 ) {
            time = ( parseInt( splits[ 0 ], 10 ) * 60 ) + parseInt( splits[ 1 ], 10 );
        }
        return time;
    },

    toPercent: function( value, total, decimal ) {
		var r = Math.pow( 10, decimal || 0 );

		return Math.round( ( ( value * 100 ) / total ) * r ) / r;
    },

    fromPercent: function( percent, total, decimal ) {
		var r = Math.pow( 10, decimal || 0 );

        return  Math.round( ( ( total / 100 ) * percent ) * r ) / r;
    }
};

// Generated by CoffeeScript 1.3.3
var Kona;

Kona = window.Kona = {};

Kona.debugMode = true;

Kona.debug = function(msg) {
  if (Kona.debugMode) {
    return console.log(msg);
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

Kona.Engine = {};

Kona.Engine.defaults = {
  fps: 24,
  width: 640,
  height: 480
};

Kona.Engine.start = function(canvas, fps) {
  Kona.debug('starting');
  Kona.Engine.fps = fps || Kona.Engine.defaults.fps;
  Kona.Engine.canvas = document.getElementById(canvas.id);
  Kona.Engine.ctx = Kona.Engine.canvas.getContext('2d');
  Kona.Engine.C_WIDTH = canvas.width || Kona.Engine.defaults.width;
  Kona.Engine.C_HEIGHT = canvas.height || Kona.Engine.defaults.height;
  return Kona.Engine.run();
};

Kona.Engine.run = function() {
  Kona.Engine.update();
  Kona.Engine.draw();
  return requestAnimFrame(Kona.Engine.run);
};

Kona.Engine.update = function() {};

Kona.Engine.draw = function() {};

window.requestAnimFrame = (function() {
  return window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || function(callback) {
    return setTimeout(callback, 1000 / Kona.Engine.defaults.fps);
  };
})();

// Generated by CoffeeScript 1.3.3

Kona.Scenes = {};

Kona.Scenes.scenes = [];

Kona.Scenes.currentScene = {};

Kona.Scenes.renderCurrent = function() {
  return Kona.Scenes.currentScene.render();
};

Kona.Scene = (function() {

  function Scene() {
    this.active = false;
    this.entities = [];
  }

  Scene.prototype.addEntity = function(entity) {
    return this.entities.push(entity);
  };

  Scene.prototype.loadEntities = function(entities) {
    var entity, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = entities.length; _i < _len; _i++) {
      entity = entities[_i];
      _results.push(this.addEntity(entity));
    }
    return _results;
  };

  Scene.prototype.update = function() {};

  Scene.prototype.draw = function() {};

  return Scene;

})();

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

// Generated by CoffeeScript 1.3.3

Kona.Keys = {
  name: "kona.keys",
  _handlers: {},
  _map: {
    enter: 13,
    "return": 13,
    esc: 27,
    escape: 27,
    space: 32,
    shift: 16,
    ctrl: 17,
    control: 17,
    left: 37,
    up: 38,
    right: 39,
    down: 40
  },
  bind: function(key, handler) {
    key = key.replace(/\s/g, '');
    Kona.debug("binding on key: '" + key + "' (normalized to code: " + (Kona.Keys._map[key] || key.toUpperCase().charCodeAt(0)) + ")");
    key = this._map[key] || key.toUpperCase().charCodeAt(0);
    if (!(this._handlers[key] != null)) {
      Kona.debug("  key " + key + " not found in existing handlers, setting to []\n");
      this._handlers[key] = [];
    }
    return this._handlers[key].push(handler);
  },
  dispatch: function(event) {
    var handler, key, _i, _len, _ref;
    key = event.keyCode;
    Kona.debug("\ndispatching key: " + key);
    if (!(this._handlers[key] != null)) {
      Kona.debug("  no handler found, ABORT");
    }
    if (this.reject(event) || !(this._handlers[key] != null)) {
      return;
    }
    _ref = this._handlers[key];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      handler = _ref[_i];
      handler.call();
      return false;
    }
  },
  reject: function(event) {
    var tagName;
    tagName = event.target.tagName;
    if (_.include(['INPUT', 'SELECT', 'TEXTAREA'], tagName)) {
      Kona.debug("  data input - REJECT");
    }
    return _.include(['INPUT', 'SELECT', 'TEXTAREA'], tagName);
  },
  addEvent: function(object, event, method) {
    return object.addEventListener(event, method, false);
  }
};

Kona.ready(function() {
  return Kona.Keys.addEvent(document, 'keydown', Kona.Keys.dispatch.bind(Kona.Keys));
});

// Generated by CoffeeScript 1.3.3



// Generated by CoffeeScript 1.3.3

Kona.ready(function() {
  Kona.debug('ready');
  Kona.Engine.start({
    id: 'canvas'
  });
  Kona.Keys.bind("a", function() {
    return console.log("You pressed a!");
  });
  Kona.Keys.bind("left", function() {
    return console.log("you pressed left!");
  });
  return Kona.Keys.bind('ctrl', function() {
    return console.log("you pressed ctrl");
  });
});
