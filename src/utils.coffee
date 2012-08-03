Kona.Utils =
  inspect: (obj, label) ->
    # Log the properties and values of an object for debugging
    # Optional label describes object dump
    # Also works on arrays and strings, with unsurprising results.
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

    defined_str   = (if obj? then '' else '<undefined>')
    spacer        = "  " # Indent results
    is_array      = obj instanceof Array
    is_string     = typeof obj == 'string'
    is_number     = typeof obj == 'number'

    if label?
      Kona.debug "Dumping #{label}: #{defined_str}"
    else
      Kona.debug "Dumping #{ if is_array then 'array' else typeof obj}: #{defined_str}"

    if is_array
      Kona.debug "#{spacer}[#{obj}]"    # [1,2,3]
    else if is_string
      Kona.debug "#{spacer}\"#{obj}\""  # "test"
    else if is_number
      Kona.debug "#{spacer}#{obj}"      # 5
    else
      for own key, value of obj         # x: 25
        if value instanceof Function
          Kona.debug "#{spacer}#{key}(): <function>"
        else
          Kona.debug "#{spacer}#{key}: #{value}"


  randomFromTo: (from, to) ->
    # Generate a random integer within range (inclusive)
    Math.floor(Math.random() * (to - from + 1) + from)


  findByKey: (list, key, value) ->
    _.find list, (item) -> item[key] == value
