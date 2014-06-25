describe 'SimpleAiPlayer', ->
  beforeEach ->
    @model = new TicTacToeGameModel 10
    @ai = new SimpleAiPlayer @model.clone, 1

  it 'calculates points with changed value correctly', ->
    @model.lastMove = x: 1, y: 5

    somePoints = [
      {x: 0, y: 4}
      {x: 1, y: 4}
      {x: 2, y: 6}
      {x: 4, y: 2}
    ]

    calculatedPoints = @ai.getPoints @model

    for point in somePoints
      expect(calculatedPoints).toContain point