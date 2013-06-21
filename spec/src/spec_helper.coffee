# The Mouse interface will whine if Kona.Canvas is not initialize, although a bunch of specs don't need it.
# Since it's just an extremely thin wrapper around solid DOM APIs, we can get away with punting here.
Kona.Mouse = {}
