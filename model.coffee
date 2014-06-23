class @TicTacToeGameModel
  constructor: (@mapSize = 20) ->
    @restart()

  isMoveAllowed: (tileX, tileY) ->
    (@isWithinStageBounds tileX, tileY) and @stage[tileX][tileY] == -1

  isWithinStageBounds: (tileX, tileY) ->
    tileX >= 0 and tileY >= 0 and tileX < @mapSize and tileY < @mapSize

  setField: (tileX, tileY) ->
    @stage[tileX][tileY] = if @firstPlayer then 0 else 1
    @firstPlayer = not @firstPlayer
    @lastMove =
      x: tileX
      y: tileY

  getTileNumber: ->
    if @firstPlayer then 0 else 1

  didGameEnded: ->
    directions = @_getAllDirections()
    player = @stage[@lastMove.x][@lastMove.y]
    player = 0 if player == -1

    for direction in directions
      if @_checkDirection direction, player
        @gameInProgress = false
        return finished: true, player: player

    return finished: false, player: player

  _checkDirection: (direction, player) ->
    ok = true
    for field in direction
      ok = ok and field == player
    ok

  _getAllDirections: ->
    dirChangers = @createDirectionChangers()
    (@getDirection @lastMove.x, @lastMove.y, changer[0], changer[1] for changer in dirChangers)

  createDirectionChangers: ->
    changers = []
    for i in [-1..1]
      for j in [-1..1]
        if i != 0 or j != 0
          changers.push [i, j]
    changers

  getDirection: (x, y, dirX, dirY) ->
    fields = []

    for i in [0..4]
      fields.push @stage[x][y] if @isWithinStageBounds x, y
      x += dirX
      y += dirY

    fields

  restart: =>
    @stage = ((-1 for j in [0..@mapSize - 1]) for i in [0..@mapSize - 1])
    @firstPlayer = true
    @lastMove =
      x: 0
      y: 0
    @gameInProgress = true