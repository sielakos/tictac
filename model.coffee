class @TicTacToeGameModel
  constructor: (@mapSize = 20) ->
    @stage = ((-1 for j in [0..mapSize - 1]) for i in [0..mapSize - 1])
    @firstPlayer = true
    @lastMove =
      x: Math.round mapSize/2
      y: Math.round mapSize/2

  isMoveAllowed: (tileX, tileY) ->
    @stage[tileX][tileY] == -1

  setField: (tileX, tileY) ->
    @stage[tileX][tileY] = if @firstPlayer then 0 else 1
    @firstPlayer = not @firstPlayer
    @lastMove =
      x: tileX
      y: tileY

  getTileNumber: ->
    if @firstPlayer then 0 else 1

  isGameFinished: ->


  getDirection: (x, y, dirX, dirY) ->
    fields = [@stage]


