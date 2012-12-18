Kona.Utils =

  # A thin wrapper for _.where()
  # Return the first value containing all of the key-value pairs listed in props
  # Ex:
  #   cars = [ {color: 'red', owner: 'Jon'}, {color: 'green', owner: 'Jane'} ]
  #   Kona.Utils.find(cars, { 'color': 'red' })
  #   => { color: 'red', owner: 'Jon' }
  find: (list, props) ->
    _.where(list, props)[0]

  # Generate a random integer within range (inclusive)
  randomFromTo: (from, to) ->
    Math.floor(Math.random() * (to - from + 1) + from)


  # ----------------------
  #   DEBUGGING UTILS
  # ----------------------
  # Print a 2d array in a grid format
  # ex: printGrid [[1,2], [3,4]]
  #   [
  #     [1, 2]
  #     [3, 4]
  #   ]
  printGrid: (grid) ->
    output = "[\n"

    for row in grid
      output += "  ["
      for item, idx in row
        output += "#{item}"
        output += ", " unless idx == row.length-1
      output += "]\n"

    console.log "#{output}]"

  colorFor: (num) ->
    switch num
      when 1 then 'red'
      when 2 then 'orange'
      when 3 then 'blue'
      else 'blank'


# Do something only once (useful for debugging within run loops).
# Ex:
#   while true
#     once -> console.log "This will only be logged once"
window._k_once = 0; window.once = (fxn) -> fxn() if window._k_once == 0; window._k_once++
