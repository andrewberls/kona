Kona.Utils =
  inspect: (obj, label) ->
    # Log the properties and values of an object for debugging
    # Optional label describes object dump
    #
    # Usage:
    #   var car = { color: 'red', drive: function() {} }
    #
    #   Kona.Utils.inspect(car)  ---->
    #     Dumping object:
    #       color: red
    #       drive(): <function>
    #
    #   Kona.Utils.inspect(car, 'car info')  ---->
    #     Dumping car info:
    #       color: red
    #       drive(): <function>

    defined = (if obj? then '' else '<undefined>')

    if label?
      Kona.debug "Dumping #{label}: #{defined}"
    else
      Kona.debug "Dumping object: #{defined}"

    for own key, value of obj
      if value instanceof Function
        Kona.debug "  #{key}(): <function>"
      else
        Kona.debug "  #{key}: #{value}"


  randomFromTo: (from, to) ->
    # Generate a random integer within range (inclusive)
    Math.floor(Math.random() * (to - from + 1) + from)


  findByKey: (list, key, value) ->
    _.find list, (item) -> item[key] == value
