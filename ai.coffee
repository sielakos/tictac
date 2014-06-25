class @SimpleAiPlayer
  constructor: (@makeModelCopy, @playerNumber) ->
    @valueMatrix = null

  askForMove: (callback) ->
    window.setTimeout (@calculcateMove callback), 0

  calculcateMove: (callback) ->
    =>
      model = @makeModelCopy()
      @valueMatrix = @createValueMatrixIfDoesntExists @valueMatrix

  createValueMatrixIfDoesntExists: (model, matrix) ->
    if not matrix
      ((0 for j in [0 .. model.mapSize - 1]) for i in [0 .. model.mapSize -1])
    else
      matrix

  updatePointsMatrix: (model) ->


  getPoints: (model) ->
    changers = model.createDirectionChangers()
    points = [model.lastMove]

    for changer in changers
      x = model.lastMove.x
      y = model.lastMove.y
      for i in [1..4]
        x += changer[0]
        y += changer[1]
        points.push x: x, y: y if model.isWithinStageBounds x, y

    points






