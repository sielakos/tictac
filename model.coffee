class @TicTacToeGameModel
  constructor: (@mapSize = 20) ->
    @stage = ((-1 for j in [0..mapSize - 1]) for i in [0..mapSize - 1])
    @firstPlayer = true
    @lastMove =
      x: Math.round mapSize/2
      y: Math.round mapSize/2

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

  isGameFinished: ->



  createDirectionChangers: ->
    directions = []
    for i in [-1..1]
      for j in [-1..1]
        if i != 0 or j != 0
          directions.push [i, j]
    directions

  getDirection: (x, y, dirX, dirY) ->
    fields = []

    for i in [0..4]
      fields.push @stage[x][y] if @isWithinStageBounds x, y
      x += dirX
      y += dirY

    fields