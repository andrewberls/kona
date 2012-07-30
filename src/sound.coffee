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


      @increaseVolume = (value = 1) ->
        return @setVolume(@volume + value)


      @decreaseVolume = (value = 1)
        return @setVolume(@volume - value)


      @setTime = (time) ->
        return @ if !supported
        @whenReady ->
          @sound.currentTime = time
          return @


      @getTime = ->
        return null if !supported
        time = Math.round(@sound.currentTime * 100) / 100
        return (if isNaN(time) then buzz.defaults.placeholder else time)


      @setPercent = (percent) ->
        return @ if !supported
        return @setTime(buzz.fromPercent(percent, @sound.duration))


      @getPercent = ->
        return @ if !supported
        percent = Math.round(buzz.toPercent(@sound.currentTime, @sound.duration))
        return (if isNaN(percent) then buzz.defaults.placeholder else percent)


      @setSpeed = (duration) ->
        return (if supported then @sound.playbackRate = duration else null)


      @getSpeed = ->
        return (if supported then @sound.playbackRate else null)


      @getDuration = ->
        return null if !supported
        duration = Math.round(@sound.duration * 100) / 100
        return (if isNaN(duration) then buzz.defaults.placeholder else duration)


      @getPlayed = ->
        return (if supported then timerangeToArray(@sound.played) else null)


      @getBuffered = ->
        return (if supported then timerangeToArray(@sound.buffered) else null)


      @getSeekable = ->
        return (if supported then timerangeToArray(@sound.seekable) else null)


      @getErrorCode = ->
        if supported and @sound.error
          return @sound.error.code
        return 0


      @getErrorMessage = ->
        return null if !supported
          switch @getErrorCode
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


      @getStateCode = ->
        return null if !supported
        return @sound.readyState


      @getStateMessage = ->
        return null if !supported
          switch @getStateCode
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


      @getNetworkStateCode = ->
        return null if !supported
        return @sound.networkState


      @getNetworkStateMessage = ->
        return null if !supported
          switch @getNetworkStateCode
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


      @set = (key, value) ->
        return @ if !supported


      @sound[key] = value
        return @


      @get = (key) ->
        return null if !supported
        return if key then @sound[key] else @sound


# I left this kind of untouched because I wasn't sure of how to deal with line 259
      @bind = (types, func) ->
        return @ if !supported
        types = types.split( ' ' )
        that = @,
        efunc = function( e ) { func.call(that, e) }
          for( var t = 0 t < types.length t++ ) {
              type = types[t],
              idx = type
              type = idx.split('.')[0]
              events.push({idx: idx, func: efunc})
              @sound.addEventListener(type, efunc, true)
          }
          return @
      }


# I need to go over this one too
      @unbind = (types) ->
        return @ if !supported
        types = types.split(' ')
          #for( var t = 0 t < types.length t++ ) {
           #   var idx = types[ t ],
            #      type = idx.split( '.' )[ 0 ]
          for t in types
            idx = t
            type = idx.split('.')[0]
              for( var i = 0 i < events.length i++ ) {
                #for i in events
                temp = i
                  #var namespace = events[ i ].idx.split( '.' )
                  namespace = temp.idx.split('.')
                  if (events[i].idx == idx || (namespace[1] && namespace[1] == idx.replace( '.', '' ) ) ) {
                      @sound.removeEventListener( type, events[ i ].func, true )
                      // remove event
                      events.splice(i, 1)
                  }
              }
          }
          return @
      }


# Do you remove the ( and { from lines 302 and 307?
      @bindOnce = (type, func) ->
        return @ if !supported
        that = @
        eventsOnce[pid++] = false
        @bind(pid + type, function() {
          if !eventsOnce[pid]
            eventsOnce[pid] = true
            func.call(that)
             @unbind(pid + type)
          })


      @trigger = (types) ->
        return @ if !supported
        types = types.split( ' ' )
        for( var t = 0 t < types.length t++ ) {
            var idx = types[t]
            for( var i = 0 i < events.length i++ ) {
                var eventType = events[ i ].idx.split( '.' )
                if ( events[ i ].idx == idx || ( eventType[ 0 ] && eventType[ 0 ] == idx.replace( '.', '' ) ) ) {
                  var evt = document.createEvent('HTMLEvents')
                  evt.initEvent( eventType[ 0 ], false, true )
                  @sound.dispatchEvent(evt)
                  }
              }
          }
        return @


# Something with fadeTo and doFade
      @fadeTo = (to, duration, callback) ->
        return @ if !supported
        if duration instanceof Function
          callback = duration
          duration = buzz.defaults.duration
        else
          duration = duration || buzz.defaults.duration
        from = @volume,
        delay = duration / Math.abs(from - to),
        that = @
        @play()


        function doFade() {
          setTimeout( function() {
          if ( from < to and that.volume < to ) {
            that.setVolume( that.volume += 1 )
            doFade()
          } else if ( from > to and that.volume > to ) {
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


      @fadeIn = (duration, callback) ->
        return @ if !supported
        return @setVolume(0).fadeTo(100, duration, callback)


      @fadeOut = (duration, callback) ->
        return @ if !supported
        return @fadeTo(0, duration, callback)


# Check here too
      @fadeWith = (sound, duration) ->
        return @ if !supported
        @fadeOut (duration), ->
          @stop()
        sound.play().fadeIn(duration)
        return @


# Check here too
      @whenReady = (func) ->
        return null if !supported
        that = @
        if @sound.readyState === 0
          @bind ('canplay.buzzwhenready'), ->
            func.call(that)
        else
          func.call(that)

        # privates
# Another check
# It was an object with a collection of key value pairs
      timeRangeToArray = (timeRange) ->
        array = []
        length = timeRange.length - 1
        for(var i = 0 i <= length i++)
          array.push(
          start: timeRange.start(length)
          end: timeRange.end(length)
          )
        return array


      getExt = (filename) ->
        return filename.split('.').pop()


      addSource = (sound, src) ->
        source = document.createElement( 'source' )
        source.src = src
        if buzz.types[getExt(src)]
          source.type = buzz.types[getExt(src)]
        sound.appendChild(source)

        # init
        # So is this whole block of code belong to addSource?
        # There was already a closed bracket above this to close out the function
        if supported and src {
            for var i in buzz.defaults
              if buzz.defaults.hasOwnProperty(i)
                options[i] = options[i] || buzz.defaults[i]

            @sound = document.createElement('audio')

            if src instanceof Array
                for var j in src
                  if src.hasOwnProperty(j)
                    addSource(@sound, src[j])
            else if options.formats.length
                for var k in options.formats
                  if(options.formats.hasOwnProperty(k))
                    addSource(@sound, src + '.' + options.formats[k])
            else
              addSource(@sound, src)

            if options.loop
              @loop()

            if options.autoplay
              @sound.autoplay = 'autoplay'

            if options.preload === true
              @sound.preload = 'auto'
            else if options.preload === false
              @sound.preload = 'none'
            else
              @sound.preload = options.preload

            @setVolume(options.volume)

            buzz.sounds.push(@)
        }
    },




    group: (sounds) ->
      sounds = argsToArray(sounds, arguments)

      // publics
      @getSounds = ->
        return sounds

      @add = (soundArray) ->
        soundArray = argsToArray(soundArray, arguments)
        for var a = 0 a < soundArray.length a++
          sounds.push(soundArray[a])
      #    for sound in soundArray
      #      sounds.push(push)

# Can be redone
      @remove = (soundArray) ->
        soundArray = argsToArray(soundArray, arguments)
          for( var a = 0 a < soundArray.length a++ )
            for( var i = 0 i < sounds.length i++ )
              if (sounds[ i ] == soundArray[ a ])
                delete sounds[i]
                break


      @load = ->
        fn( 'load' )
        return @


      @play = ->
        fn( 'play' )
        return @


      @togglePlay = ->
        fn('togglePlay')
        return @


      @pause = (time)
        fn('pause', time)
        return @


      @stop = ->
        fn('stop')
        return @


      @mute = ->
        fn('mute')
        return @


      @unmute = ->
        fn('unmute')
        return @


      @toggleMute = ->
        fn('toggleMute')
        return @


      @setVolume = (volume) ->
        fn('setVolume', volume)
        return @


      @increaseVolume = (value) ->
        fn('increaseVolume', value)
        return @


      @decreaseVolume = (value) ->
        fn('decreaseVolume', value)
        return @


      @loop = ->
        fn('loop')
        return @


      @unloop = ->
        fn('unloop')
        return @


      @setTime = (time) ->
        fn('setTime', time)
        return @


      @setDuration = (duration) ->
        fn('setDuration', duration)
        return @


      @set = (key, value) ->
        fn('set', key, value)
        return @


      @bind = (type, func) ->
        fn('bind', type, func)
        return @


      @unbind = (type) ->
        fn('unbind', type)
        return @


      @bindOnce = (type, func) ->
        fn('bindOnce', type, func)
        return @


      @trigger = (type) ->
        fn('trigger', type)
        return @

      @fade = (from, to, duration, callback) ->
        fn('fade', from, to, duration, callback)
        return @


      @fadeIn = (duration, callback) ->
        fn('fadeIn', duration, callback)
        return @


      @fadeOut = (duration, callback) ->
        fn('fadeOut', duration, callback)
        return @


      // privates
      fn = ->
        args = argsToArray(null, arguments)
        func = args.shift()
        for i in sounds
        #for( var i = 0 i < sounds.length i++ ) {
          sounds[i][func].apply(sounds[i], args)
        argsToArray = (array, args) ->
        return (array instanceof Array) ? array : Array.prototype.slice.call(args)
    #},


    #all: function()
    all: ->
      return new buzz.group(buzz.sounds)


    isSupported: ->
      return !!buzz.el.canPlayType


    isOGGSupported: ->
      return !!buzz.el.canPlayType and buzz.el.canPlayType('audio/ogg codecs="vorbis"')


    isWAVSupported: ->
      return !!buzz.el.canPlayType and buzz.el.canPlayType('audio/wav codecs="1"')


    isMP3Supported: ->
      return !!buzz.el.canPlayType and buzz.el.canPlayType('audio/mpeg')


    isAACSupported: ->
      return !!buzz.el.canPlayType and (buzz.el.canPlayType('audio/x-m4a') || buzz.el.canPlayType('audio/aac'))


    toTimer: (time, withHours) ->
      h = Math.floor(time / 3600)
      h = isNaN(h) ? '--' : ( h >= 10 ) ? h : '0' + h
      m = withHours ? Math.floor(time / 60 % 60) : Math.floor(time / 60)
      m = isNaN(m) ? '--' : (m >= 10) ? m : '0' + m
      s = Math.floor(time % 60)
      s = isNaN(s) ? '--' : (s >= 10) ? s : '0' + s
      return withHours ? h + ':' + m + ':' + s : m + ':' + s


    fromTimer: (time) ->
      splits = time.toString().split(':')
      if splits and splits.length == 3
        time = (parseInt(splits[0], 10) * 3600) + (parseInt(splits[1], 10) * 60) + parseInt(splits[2], 10)
      if splits and splits.length == 2
        time = (parseInt(splits[0], 10) * 60) + parseInt(splits[1], 10)
      return time


    toPercent: (value, total, decimal) ->
      r = Math.pow(10, decimal || 0)
      return Math.round(((value * 100) / total) * r) / r


    fromPercent: (percent, total, decimal) ->
      r = Math.pow(10, decimal || 0)
      return Math.round(((total / 100) * percent) * r) / r

#test
