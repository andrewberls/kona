# Abstract class for a health powerup
class HealthPowerup extends Kona.Collectable
  value: 0

  activate: (collector) ->
    super
    console.log "got #{@value} health"
    collector.health += @value


class Coffee extends HealthPowerup
  value: 10

  constructor: (opts={}) ->
    super(opts)
    @pickupSound = 'coffee'


class Espresso extends HealthPowerup
  value: 15

  constructor: (opts={}) ->
    super(opts)
    @pickupSound = ''


class Pill extends HealthPowerup
  value: 20

  constructor: (opts={}) ->
    super(opts)
    @pickupSound = 'pills'



class Coin extends Kona.Collectable
  value: 10

  constructor: (opts={}) ->
    super(opts)
    @pickupSound = ['coin1', 'coin2']

  activate: (collector) ->
    super
    console.log "got #{@value} score"
    collector.score += @value



