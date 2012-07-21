# TODO: Sound is difficult to handle - will be looking into vendor libs.
# This is just a placeholder with potential example usage.

Kona.Sound = {}

Kona.Sound._sounds = [] # Internal tracking array

Kona.Sound.registerAssets = (sounds) ->
  _.each sounds, (name, path) ->
    # Slice optional period off path
    # Add sound to tracked list

Kona.Sound.play = (name) ->
  # Find song in tracked list and play
  # Use the extension if provided, or default to the default Kona.sound.extension
  # Must be period agnostic



Kona.Sound.extension = 'ogg' # Register extension for all sound files.

Kona.Sound.registerAssets {
  # Use extension if provided, or default to options extension
  'player_fire' : 'fire.ogg',
  'player_death' : 'death.ogg'
}

Kona.Sound.play 'player_fire'
