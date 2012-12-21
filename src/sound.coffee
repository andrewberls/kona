# Ex:
#   Kona.Sounds.load {
#     'fire' : 'enemy_fire.ogg'
#   }
#   Kona.Sounds.play('fire')

Kona.Sounds =
  sounds: {}

  load: (sounds={}) ->
    for name, src of sounds
      @sounds[name] = new Kona.Sound(src)

  play: (name) ->
    @sounds[name].play()




# Ex:
#   fire = new Kona.Sound('enemy_fire.ogg')
#   fire.play()

class Kona.Sound
  # --------------------
  # Class methods
  # --------------------
  @defaults:
    autoplay: false
    duration: 5000
    formats: []
    loop: false
    placeholder: '--'
    preload: 'metadata'
    volume: 100

  @types:
    'mp3': 'audio/mpeg'
    'ogg': 'audio/ogg'
    'wav': 'audio/wav'
    'aac': 'audio/aac'
    'm4a': 'audio/x-m4a'

  @testEl: document.createElement('audio')
  @isSupported:    -> return !!@testEl.canPlayType
  @isOGGSupported: -> @testEl.canPlayType('audio/ogg codecs="vorbis"')
  @isWAVSupported: -> @testEl.canPlayType('audio/wav codecs="1"')
  @isMP3Supported: -> @testEl.canPlayType('audio/mpeg codecs="mp3"')
  @isAACSupported: -> (@testEl.canPlayType('audio/x-m4a') || @testEl.canPlayType('audio/aac'))


  # Run tests for supported audio formats
  # Ex for Chrome 23.0.1271.64:
  # Kona.Sound.supportedFormats()
  #   OGG: yes
  #   WAV: yes
  #   MP3: yes
  #   AAC: maybe
  @supportedFormats: ->
    supported = (check) -> if check == '' then 'yes' else check
    Kona.debug "Audio format compatability:"
    Kona.debug "  OGG: #{ supported(@isOGGSupported()) }"
    Kona.debug "  WAV: #{ supported(@isWAVSupported()) }"
    Kona.debug "  MP3: #{ supported(@isMP3Supported()) }"
    Kona.debug "  AAC: #{ supported(@isAACSupported()) }"


  # --------------------
  # Instance methods
  # --------------------
  # Options:
  #  - formats
  #  - (x) loop
  #  - autoplay
  #  - preload
  #  - volume
  constructor: (src, options={}) ->
    @supported  = Kona.Sound.isSupported()

    if @supported && src?
      for key, value of Kona.Sound.defaults
        options[key] = options[key] || value

    @el = document.createElement('audio')

    if _.isArray(src)
      @addSource(@el, s) for s in src
    else if options.formats? && options.formats.length
      for key, value in options.formats
        @addSource(@el, "#{src}.#{key}")
    else
      @addSource(@el, src)

    # @loop() if options.loop
    @el.autoplay = 'autoplay' if options.autoplay == true
    @el.preload  = if options.preload == true then 'auto' else 'none'
    @setVolume(options.volume)

    @el.addEventListener "loadedmetadata", => @duration = @el.duration


  getExt: (filename) -> filename.split('.').pop()

  addSource: (el, src) ->
    source     = document.createElement('source')
    source.src = src
    ext = @getExt(src)
    if Kona.Sound.types[ext]?
      source.type = Kona.Sound.types[ext]
    el.appendChild(source)

  load: -> if @supported then @el.load() else @

  play: -> if @supported then @el.play() else @

  togglePlay: ->
    return @ if !@supported
    if @el.paused then @el.play() else @el.pause()
    return @

  pause: -> if @supported then @el.pause() else @

  isPaused: -> if @supported then @el.paused else null

  stop: ->
    if @supported
      @el.currentTime = @el.duration
      @el.pause()
    else
      null

  isEnded: -> if @supported then @el.ended else null

  getDuration: -> if @supported then @duration else null

  mute: -> if @supported then @el.muted = true else null

  unmute: -> if @supported then @el.muted = false else null

  isMuted: -> if @supported then @el.muted else null

  toggleMute: -> if @supported then @el.muted = !@el.muted else null

  # Set volume, on a scale of 1-100.
  # Value is automatically scaled for audio tag
  setVolume: (volume) ->
    return @ if !@supported
    volume  = 0   if volume < 0
    volume  = 100 if volume > 100
    @volume = volume
    @el.volume = volume / 100
    return @

  getVolume: -> if @supported then @volume else null

  increaseVolume: (value=1) -> @setVolume(@volume + value)

  decreaseVolume: (value=1) -> @setVolume(@volume - value)

  getTime: ->
    return null if !@supported
    time = Math.round(@el.currentTime * 100) / 100
    if isNaN(time) then Kona.Sound.defaults.placeholder else time

  getDuration: -> if @supported then @el.duration else null

  # setTime: (time) ->
  #   return @ if !@supported
  #   @whenReady ->
  #     @el.currentTime = time
  #     return @

  # setPercent: (percent) ->
  #   return @ if !@supported
  #   return @setTime(Kona.Sound.fromPercent(percent, @el.duration))

  # getPercent: ->
  #   return @ if !@supported
  #   percent = Math.round(Kona.Sound.toPercent(@el.currentTime, @el.duration))
  #   return (if isNaN(percent) then Kona.Sound.defaults.placeholder else percent)

  # toPercent: (value, total, decimal) ->
  #   r = Math.pow(10, decimal || 0)
  #   return Math.round(((value * 100) / total) * r) / r


  # fromPercent: (percent, total, decimal) ->
  #   r = Math.pow(10, decimal || 0)
  #   return Math.round(((total / 100) * percent) * r) / r

  # loop: ->

  # unloop: ->
