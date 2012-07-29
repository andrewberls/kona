# OGG - Firefox, Chrome, Opera
# MP3 - IE


# Interface for defining and playing sound assets
# Uses the Buzz HTML5 audio library by Jay Salvat
# http://buzz.jaysalvat.com/

Kona.Sound =
    defaults:
      autoplay: false,
      duration: 5000,
      formats: [],
      loop: false,
      placeholder: '--',
      preload: 'metadata',
      volume: 80

    types:
      'mp3': 'audio/mpeg',
      'ogg': 'audio/ogg',
      'wav': 'audio/wav',
      'aac': 'audio/aac',
      'm4a': 'audio/x-m4a'

    sounds: []

    el: document.createElement( 'audio' )

    sound: (src, options={}) ->
      pid        = 0
      events     = []
      eventsOnce = {}
      supported  = buzz.isSupported()

      # publics
      @load = ->
        return (if supported then @sound.load() else @)


      @play = ->
        return (if supported then @sound.play() else @)


      @togglePlay = ->
        return @ if !supported

        if @sound.paused
          @sound.play()
        else
          @sound.pause()
        return @


      @pause = ->
        return (if supported then @sound.pause() else @)


      @isPaused = ->
        return (if supported then @sound.paused else null)


      @stop = ->
          return @ if !supported

          @setTime( @getDuration() )
          @sound.pause()
          return @


      @isEnded = ->
        return (if supported then @sound.ended else null)


      @loop = ->
        return @ if !supported

        @sound.loop = 'loop'
        @bind( 'ended.buzzloop', ->
            @currentTime = 0
            @play()
        return @


      @unloop = ->
        return @ if !supported

        @sound.removeAttribute 'loop'
        @unbind 'ended.buzzloop'
        return @


      @mute = ->
        return @ if !supported

        @sound.muted = true
        return @


        @unmute = ->
          return (if supported then @sound.muted = false else null)


        @toggleMute = ->
          return (if supported then @sound.muted = !@sound.muted else null)


        @isMuted = ->
          return (if supported then @sound.muted else null)


      @setVolume = (volume) ->
          return @ if !supported
          volume = 0 if volume < 0
          volume = 100 if volume > 100

          @volume = volume
          @sound.volume = volume / 100
          return @


      @getVolume = ->
        return (if supported then @volume = false else null)


        @increaseVolume = (value=1) ->
          return @setVolume(@volume + value)


        @decreaseVolume = (value=1)
          return @setVolume(this.volume - value)


        @setTime = (time) ->
            return @ if !supported

            @whenReady ->
              @sound.currentTime = time
            return @


        @getTime = ->
          return null if !supported

          time = Math.round( @sound.currentTime * 100 ) / 100
          return (if isNaN(time) then buzz.defaults.placeholder else time)


        @setPercent = (percent) ->
          return @ if !supported

          return @setTime( buzz.fromPercent( percent, @sound.duration ) )


        @getPercent = ->
          return @ if !supported

          percent = Math.round( buzz.toPercent( @sound.currentTime, @sound.duration ) )
          return (if isNaN(percent) then buzz.defaults.placeholder else percent)


        @setSpeed = (duration) ->
          return (if supported then @sound.playbackRate = duration else null)


        @getSpeed = ->
          return (if supported then @sound.playbackRate else null)


        @getDuration = ->
          return null if !supported

          duration = Math.round( this.sound.duration * 100 ) / 100
          return (if isNaN(duration) then buzz.defaults.placeholder else duration)


        @getPlayed = ->
          return (if supported then timerangeToArray(@sound.played) else null)


        @getBuffered = ->
          return (if supported then timerangeToArray(@sound.buffered) else null)


        @getSeekable = ->
          return (if supported then timerangeToArray(@sound.seekable) else null)









        this.getErrorCode = function() {
            if ( supported && this.sound.error ) {
                return this.sound.error.code
            }
            return 0
        }

        this.getErrorMessage = function() {
          return null if !supported

            switch( this.getErrorCode() ) {
                case 1:
                    return 'MEDIA_ERR_ABORTED'
                case 2:
                    return 'MEDIA_ERR_NETWORK'
                case 3:
                    return 'MEDIA_ERR_DECODE'
                case 4:
                    return 'MEDIA_ERR_SRC_NOT_SUPPORTED'
                default:
                    return null
            }
        }

        this.getStateCode = function() {
          return null if !supported

            return this.sound.readyState
        }











        this.getStateMessage = function() {
          return null if !supported

            switch( this.getStateCode() ) {
                case 0:
                    return 'HAVE_NOTHING'
                case 1:
                    return 'HAVE_METADATA'
                case 2:
                    return 'HAVE_CURRENT_DATA'
                case 3:
                    return 'HAVE_FUTURE_DATA'
                case 4:
                    return 'HAVE_ENOUGH_DATA'
                default:
                    return null
            }
        }

        this.getNetworkStateCode = function() {
          return null if !supported

            return this.sound.networkState
        }








        this.getNetworkStateMessage = function() {
          return null if !supported

            switch( this.getNetworkStateCode() ) {
                case 0:
                    return 'NETWORK_EMPTY'
                case 1:
                    return 'NETWORK_IDLE'
                case 2:
                    return 'NETWORK_LOADING'
                case 3:
                    return 'NETWORK_NO_SOURCE'
                default:
                    return null
            }
        }

        this.set = function( key, value ) {
            return this if !supported

            this.sound[ key ] = value
            return this
        }












        this.get = function( key ) {
          return null if !supported

          return key ? this.sound[ key ] : this.sound
        }

        this.bind = function( types, func ) {
            return this if !supported

            types = types.split( ' ' )

            var that = this,
        efunc = function( e ) { func.call( that, e ) }

            for( var t = 0 t < types.length t++ ) {
                var type = types[ t ],
                    idx = type
                    type = idx.split( '.' )[ 0 ]

                    events.push( { idx: idx, func: efunc } )
                    this.sound.addEventListener( type, efunc, true )
            }
            return this
        }















        this.unbind = function( types ) {
            return this if !supported

            types = types.split( ' ' )

            for( var t = 0 t < types.length t++ ) {
                var idx = types[ t ],
                    type = idx.split( '.' )[ 0 ]

                for( var i = 0 i < events.length i++ ) {
                    var namespace = events[ i ].idx.split( '.' )
                    if ( events[ i ].idx == idx || ( namespace[ 1 ] && namespace[ 1 ] == idx.replace( '.', '' ) ) ) {
                        this.sound.removeEventListener( type, events[ i ].func, true )
                        // remove event
                        events.splice(i, 1)
                    }
                }
            }
            return this
        }
















        this.bindOnce = function( type, func ) {
            return this if !supported

            var that = this

            eventsOnce[ pid++ ] = false
            this.bind( pid + type, function() {
               if ( !eventsOnce[ pid ] ) {
                   eventsOnce[ pid ] = true
                   func.call( that )
               }
               that.unbind( pid + type )
            })
        }

        this.trigger = function( types ) {
            return this if !supported

            types = types.split( ' ' )

            for( var t = 0 t < types.length t++ ) {
                var idx = types[ t ]

                for( var i = 0 i < events.length i++ ) {
                    var eventType = events[ i ].idx.split( '.' )
                    if ( events[ i ].idx == idx || ( eventType[ 0 ] && eventType[ 0 ] == idx.replace( '.', '' ) ) ) {
                        var evt = document.createEvent('HTMLEvents')
                        evt.initEvent( eventType[ 0 ], false, true )
                        this.sound.dispatchEvent( evt )
                    }
                }
            }
            return this
        }













        this.fadeTo = function( to, duration, callback ) {
           return this if !supported

            if ( duration instanceof Function ) {
                callback = duration
                duration = buzz.defaults.duration
            } else {
                duration = duration || buzz.defaults.duration
            }

            var from = this.volume,
        delay = duration / Math.abs( from - to ),
                that = this
            this.play()

            function doFade() {
                setTimeout( function() {
                    if ( from < to && that.volume < to ) {
                        that.setVolume( that.volume += 1 )
                        doFade()
                    } else if ( from > to && that.volume > to ) {
                        that.setVolume( that.volume -= 1 )
                        doFade()
                    } else if ( callback instanceof Function ) {
                        callback.apply( that )
                    }
                }, delay )
            }
            this.whenReady( function() {
                doFade()
            })

            return this
        }















        this.fadeIn = function( duration, callback ) {
            return this if !supported

            return this.setVolume(0).fadeTo( 100, duration, callback )
        }

        this.fadeOut = function( duration, callback ) {
           return this if !supported

            return this.fadeTo( 0, duration, callback )
        }

        this.fadeWith = function( sound, duration ) {
            return this if !supported

            this.fadeOut( duration, function() {
                this.stop()
            })

            sound.play().fadeIn( duration )

            return this
        }












        this.whenReady = function( func ) {
            return null if !supported

            var that = this
            if ( this.sound.readyState === 0 ) {
                this.bind( 'canplay.buzzwhenready', function() {
                    func.call( that )
                })
            } else {
                func.call( that )
            }
        }

        // privates
        function timerangeToArray( timeRange ) {
            var array = [],
                length = timeRange.length - 1

            for( var i = 0 i <= length i++ ) {
                array.push({
                    start: timeRange.start( length ),
                    end: timeRange.end( length )
                })
            }
            return array
        }
















        function getExt( filename ) {
            return filename.split('.').pop()
        }

        function addSource( sound, src ) {
            var source = document.createElement( 'source' )
            source.src = src
            if ( buzz.types[ getExt( src ) ] ) {
                source.type = buzz.types[ getExt( src ) ]
            }
            sound.appendChild( source )
        }





















        // init
        if ( supported && src ) {

            for(var i in buzz.defaults ) {
              if(buzz.defaults.hasOwnProperty(i)) {
                options[ i ] = options[ i ] || buzz.defaults[ i ]
              }
            }

            this.sound = document.createElement( 'audio' )

            if ( src instanceof Array ) {
                for( var j in src ) {
                  if(src.hasOwnProperty(j)) {
                    addSource( this.sound, src[ j ] )
                  }
                }
            } else if ( options.formats.length ) {
                for( var k in options.formats ) {
                  if(options.formats.hasOwnProperty(k)) {
                    addSource( this.sound, src + '.' + options.formats[ k ] )
                  }
                }
            } else {
                addSource( this.sound, src )
            }

            if ( options.loop ) {
                this.loop()
            }

            if ( options.autoplay ) {
                this.sound.autoplay = 'autoplay'
            }

            if ( options.preload === true ) {
                this.sound.preload = 'auto'
            } else if ( options.preload === false ) {
                this.sound.preload = 'none'
            } else {
                this.sound.preload = options.preload
            }

            this.setVolume( options.volume )

            buzz.sounds.push( this )
        }
    },
















    group: function( sounds ) {
        sounds = argsToArray( sounds, arguments )

        // publics
        this.getSounds = function() {
            return sounds
        }

        this.add = function( soundArray ) {
            soundArray = argsToArray( soundArray, arguments )
            for( var a = 0 a < soundArray.length a++ ) {
                sounds.push( soundArray[ a ] )
            }
        }

        this.remove = function( soundArray ) {
            soundArray = argsToArray( soundArray, arguments )
            for( var a = 0 a < soundArray.length a++ ) {
                for( var i = 0 i < sounds.length i++ ) {
                    if ( sounds[ i ] == soundArray[ a ] ) {
                        delete sounds[ i ]
                        break
                    }
                }
            }
        }












        this.load = function() {
            fn( 'load' )
            return this
        }

        this.play = function() {
            fn( 'play' )
            return this
        }

        this.togglePlay = function( ) {
            fn( 'togglePlay' )
            return this
        }

        this.pause = function( time ) {
            fn( 'pause', time )
            return this
        }

        this.stop = function() {
            fn( 'stop' )
            return this
        }

        this.mute = function() {
            fn( 'mute' )
            return this
        }

        this.unmute = function() {
            fn( 'unmute' )
            return this
        }

        this.toggleMute = function() {
            fn( 'toggleMute' )
            return this
        }









        this.setVolume = function( volume ) {
            fn( 'setVolume', volume )
            return this
        }

        this.increaseVolume = function( value ) {
            fn( 'increaseVolume', value )
            return this
        }

        this.decreaseVolume = function( value ) {
            fn( 'decreaseVolume', value )
            return this
        }

        this.loop = function() {
            fn( 'loop' )
            return this
        }

        this.unloop = function() {
            fn( 'unloop' )
            return this
        }

        this.setTime = function( time ) {
            fn( 'setTime', time )
            return this
        }

        this.setduration = function( duration ) {
            fn( 'setduration', duration )
            return this
        }








        this.set = function( key, value ) {
            fn( 'set', key, value )
            return this
        }

        this.bind = function( type, func ) {
            fn( 'bind', type, func )
            return this
        }

        this.unbind = function( type ) {
            fn( 'unbind', type )
            return this
        }

        this.bindOnce = function( type, func ) {
            fn( 'bindOnce', type, func )
            return this
        }

        this.trigger = function( type ) {
            fn( 'trigger', type )
            return this
        }

        this.fade = function( from, to, duration, callback ) {
            fn( 'fade', from, to, duration, callback )
            return this
        }

        this.fadeIn = function( duration, callback ) {
            fn( 'fadeIn', duration, callback )
            return this
        }

        this.fadeOut = function( duration, callback ) {
            fn( 'fadeOut', duration, callback )
            return this
        }









        // privates
        function fn() {
            var args = argsToArray( null, arguments ),
                func = args.shift()

            for( var i = 0 i < sounds.length i++ ) {
                sounds[ i ][ func ].apply( sounds[ i ], args )
            }
        }

        function argsToArray( array, args ) {
            return ( array instanceof Array ) ? array : Array.prototype.slice.call( args )
        }
    },


    all: function() {
      return new buzz.group( buzz.sounds )
    },

    isSupported: function() {
        return !!buzz.el.canPlayType
    },

    isOGGSupported: function() {
        return !!buzz.el.canPlayType && buzz.el.canPlayType( 'audio/ogg codecs="vorbis"' )
    },
















    isWAVSupported: function() {
        return !!buzz.el.canPlayType && buzz.el.canPlayType( 'audio/wav codecs="1"' )
    },

    isMP3Supported: function() {
        return !!buzz.el.canPlayType && buzz.el.canPlayType( 'audio/mpeg' )
    },

    isAACSupported: function() {
        return !!buzz.el.canPlayType && ( buzz.el.canPlayType( 'audio/x-m4a' ) || buzz.el.canPlayType( 'audio/aac' ) )
    },

    toTimer: function( time, withHours ) {
        var h, m, s
        h = Math.floor( time / 3600 )
        h = isNaN( h ) ? '--' : ( h >= 10 ) ? h : '0' + h
        m = withHours ? Math.floor( time / 60 % 60 ) : Math.floor( time / 60 )
        m = isNaN( m ) ? '--' : ( m >= 10 ) ? m : '0' + m
        s = Math.floor( time % 60 )
        s = isNaN( s ) ? '--' : ( s >= 10 ) ? s : '0' + s
        return withHours ? h + ':' + m + ':' + s : m + ':' + s
    },

    fromTimer: function( time ) {
        var splits = time.toString().split( ':' )
        if ( splits && splits.length == 3 ) {
            time = ( parseInt( splits[ 0 ], 10 ) * 3600 ) + ( parseInt(splits[ 1 ], 10 ) * 60 ) + parseInt( splits[ 2 ], 10 )
        }
        if ( splits && splits.length == 2 ) {
            time = ( parseInt( splits[ 0 ], 10 ) * 60 ) + parseInt( splits[ 1 ], 10 )
        }
        return time
    },












    toPercent: function( value, total, decimal ) {
    var r = Math.pow( 10, decimal || 0 )

    return Math.round( ( ( value * 100 ) / total ) * r ) / r
    },

    fromPercent: function( percent, total, decimal ) {
    var r = Math.pow( 10, decimal || 0 )

        return  Math.round( ( ( total / 100 ) * percent ) * r ) / r
    }
}
