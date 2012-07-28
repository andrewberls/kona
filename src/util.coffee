Kona.Utils =
  randomFromTo: (from, to) ->
    # Generate a random integer within range (inclusive)
    Math.floor(Math.random() * (to - from + 1) + from)
