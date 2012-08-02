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
        @bind 'ended.buzzloop', ->
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


      @decreaseVolume = (value = 1) ->
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
        return (if supported && @sound.error then @sound.error.code else 0)


      @getErrorMessage = ->
        return null if !supported
        switch @getErrorCode
          when 1 then 'MEDIA_ERR_ABORTED'
          when 2 then 'MEDIA_ERR_NETWORK'
          when 3 then 'MEDIA_ERR_DECODE'
          when 4 then 'MEDIA_ERR_SRC_NOT_SUPPORTED'
          else null


      @getStateCode = ->
        return (if supported then @sound.readyState else null)


      @getStateMessage = ->
        return null if !supported
        switch @getStateCode
          when 0 then 'HAVE_NOTHING'
          when 1 then 'HAVE_METADATA'
          when 2 then 'HAVE_CURRENT_DATA'
          when 3 then 'HAVE_FUTURE_DATA'
          when 4 then 'HAVE_ENOUGH_DATA'
          else null


      @getNetworkStateCode = ->
        return (if supported then @sound.networkState else null)


      @getNetworkStateMessage = ->
        return null if !supported
        switch @getNetworkStateCode
          when 0 then 'NETWORK_EMPTY'
          when 1 then 'NETWORK_IDLE'
          when 2 then 'NETWORK_LOADING'
          when 3 then 'NETWORK_NO_SOURCE'
          else null


      @set = (key, value) ->
        return (if supported then @sound[key] = value else @)


      @get = (key) ->
        if supported
          return (if key? then @sound[key] else @sound)
        else
          return null


      @bind = (types, func) ->
        return @ if !supported
        types = types.split(' ')
        self = @
        efunc = (e) -> func.call(self, e)

        for type in types
          idx = type
          type = idx.split('.')[0]
          events.push {
            idx: idx
            func: efunc
          }
          @sound.addEventListener(type, efunc, true)

        return @


      @unbind = (types) ->
        return @ if !supported
        types = types.split(' ')

        for type in types
          idx = type
          type = idx.split('.')[0]

          for event, i in events
            namespace = event.idx.split('.')
            if event.idx == idx || (namespace[1] && namespace[1] == idx.replace('.', '') )
              @sound.removeEventListener( type, event.func, true );
              events.splice(i, 1) # remove event

        return @


      @bindOnce = (type, func) ->
        return @ if !supported
        self = @
        eventsOnce[pid++] = false
        @bind pid + type, ->
          if !eventsOnce[pid]
            eventsOnce[pid] = true
            func.call(self)
            @unbind(pid + type)


      @trigger = (types) ->
        return @ if !supported
        types = types.split(' ')

        for type in types
          idx = type

          for event in events
            eventType = event.idx.split('.')
            if event.idx == idx || ( eventType[0] && eventType[0] == idx.replace('.', '') )
                  evt = document.createEvent('HTMLEvents')
                  evt.initEvent(eventType[0], false, true)
                  @sound.dispatchEvent(evt)

        return @


      @fadeTo = (to, duration, callback) ->
        return @ if !supported

        if (duration instanceof Function)
          callback = duration
          duration = Kona.Sound.defaults.duration
        else
          duration = duration || Kona.Sound.defaults.duration

        from = @volume
        delay = duration / Math.abs( from - to )
        self = @
        @play()

        doFade = ->
          setTimeout ->
              if from < to && self.volume < to
                self.setVolume(self.volume += 1)
                doFade()
              else if from > to && self.volume > to
                self.setVolume(self.volume -= 1)
                doFade()
              else if callback instanceof Function
                callback.apply(self)
          , delay

        @whenReady -> doFade()

        return @


      @fadeIn = (duration, callback) ->
        return (if supported then @setVolume(0).fadeTo(100, duration, callback) else @)


      @fadeOut = (duration, callback) ->
        return (if supported then @fadeTo(0, duration, callback) else @)


      @fadeWith = (sound, duration) ->
        return @ if !supported
        @fadeOut (duration), -> @stop()
        sound.play().fadeIn(duration)
        return @









      # TODO: KONA EVENT
      @whenReady = (func) ->
        return null if !supported
        self = @
        if @sound.readyState == 0
          @bind ('canplay.buzzwhenready'), ->
            func.call(self)
        else
          func.call(self)















      # privates
      timeRangeToArray = (timeRange) ->
        result = []
        length = timeRange.length - 1
        for num in [0..length]
          result.push(
            start: timeRange.start(length)
            end: timeRange.end(length)
          )
        return result


      getExt = (filename) ->
        return filename.split('.').pop()


      addSource = (sound, src) ->
        source = document.createElement('source')
        source.src = src
        if Kona.Sound.types[getExt(src)]?
          source.type = Kona.Sound.types[getExt(src)]
        sound.appendChild(source)














        # TODO: change buzz references to Kona.Sound


        # init
        # if supported && src
        #   for var i in buzz.defaults
        #     if buzz.defaults.hasOwnProperty(i)
        #       options[i] = options[i] || buzz.defaults[i]

        #   @sound = document.createElement('audio')

        #   if src instanceof Array
        #       for var j in src
        #         if src.hasOwnProperty(j)
        #           addSource(@sound, src[j])
        #   else if options.formats.length
        #       for var k in options.formats
        #         if(options.formats.hasOwnProperty(k))
        #           addSource(@sound, src + '.' + options.formats[k])
        #   else
        #     addSource(@sound, src)

        #   if options.loop
        #     @loop()

        #   if options.autoplay
        #     @sound.autoplay = 'autoplay'

        #   if options.preload === true
        #     @sound.preload = 'auto'
        #   else if options.preload === false
        #     @sound.preload = 'none'
        #   else
        #     @sound.preload = options.preload

        #   @setVolume(options.volume)

        #   buzz.sounds.push(@)





















    group: (sounds) ->
      sounds = argsToArray(sounds, arguments)

      # publics
      @getSounds = ->
        return sounds

      @add = (soundArray) ->
        soundArray = argsToArray(soundArray, arguments)
        for sound in soundArray
          sounds.push(sound)















# TODO: how many fucking nested loops are in this? refactor to not use traditional JS looping

# Can be redone
      # @remove = (soundArray) ->
      #   soundArray = argsToArray(soundArray, arguments)
      #     for( var a = 0 a < soundArray.length a++ )
      #       for( var i = 0 i < sounds.length i++ )
      #         if (sounds[ i ] == soundArray[ a ])
      #           delete sounds[i]
      #           break


























      @load = ->
        fn('load')
        return @


      @play = ->
        fn('play')
        return @


      @togglePlay = ->
        fn('togglePlay')
        return @


      @pause = (time) ->
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


      # privates
      fn = ->
        args = argsToArray(null, arguments)
        func = args.shift()
        for sound in sounds
          sound[func].apply(sound, args)


      argsToArray = (array, args) ->
        return (array instanceof Array) ? array : Array.prototype.slice.call(args)







    all: ->
      return new buzz.group(buzz.sounds)


    isSupported: ->
      return !!buzz.el.canPlayType


    isOGGSupported: ->
      return !!buzz.el.canPlayType && buzz.el.canPlayType('audio/ogg codecs="vorbis"')


    isWAVSupported: ->
      return !!buzz.el.canPlayType && buzz.el.canPlayType('audio/wav codecs="1"')


    isMP3Supported: ->
      return !!buzz.el.canPlayType && buzz.el.canPlayType('audio/mpeg')


    isAACSupported: ->
      return !!buzz.el.canPlayType && (buzz.el.canPlayType('audio/x-m4a') || buzz.el.canPlayType('audio/aac'))


    toTimer: (time, withHours) ->
      h = Math.floor(time / 3600)
      if isNaN(h)
        h = '--'
      else if h < 10
        h = "0#{h}"

      m = if withHours then Math.floor(time / 60 % 60) else Math.floor(time / 60)
      if isNaN(m)
        m = '--'
      else if m < 10
        m = "0#{m}"

      s = Math.floor(time % 60)
      if isNaN(s)
        s = '--'
      else if s < 10
        s = "0#{s}"

      return (if withHours then "#{h}:#{m}:#{s}:" else "#{m}:#{s}")


    fromTimer: (time) ->
      splits = time.toString().split(':')
      if splits && splits.length == 3
        time = (parseInt(splits[0], 10) * 3600) + (parseInt(splits[1], 10) * 60) + parseInt(splits[2], 10)
      if splits && splits.length == 2
        time = (parseInt(splits[0], 10) * 60) + parseInt(splits[1], 10)
      return time


    toPercent: (value, total, decimal) ->
      r = Math.pow(10, decimal || 0)
      return Math.round(((value * 100) / total) * r) / r


    fromPercent: (percent, total, decimal) ->
      r = Math.pow(10, decimal || 0)
      return Math.round(((total / 100) * percent) * r) / r

