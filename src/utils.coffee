Kona.Utils =

  # Debug util - inspect an object or raise an error if it's undefined
  require: (obj) ->
    if obj? then Kona.debug(obj) else throw new Error("Obj not defined")

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

  # Generate a random integer within range (inclusive)
  randomFromTo: (from, to) ->
    Math.floor(Math.random() * (to - from + 1) + from)


  # Find an object in a list of objects based on the value of one of its keys
  # Returns the first matching object
  # Ex:
  #   cars = [ {color: 'red', owner: 'Jon'}, {color: 'green', owner: 'Jane'} ]
  #   Kona.Utils.findByKey(cars, 'color', 'red')
  #   => { color: 'red', owner: 'Jon' }
  findByKey: (list, key, value) ->
    _.find list, (item) -> item[key] == value
