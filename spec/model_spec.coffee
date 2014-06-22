describe 'TicTacToeGameModel', ->
  beforeEach ->
    @model = new TicTacToeGameModel 20

  it 'stage has correct size', ->
    expect(@model.stage.length).toBe 20
    for i in [0..19]
      expect(@model.stage[i].length).toBe 20

  it 'isMoveAllowed checks if tile is within stage bounds and tile is free', ->
    expect(@model.isMoveAllowed 1, 2).toBe true
    expect(@model.isMoveAllowed -1, 2).toBe false
    expect(@model.isMoveAllowed 40, 2).toBe false
    expect(@model.isMoveAllowed 4, 26).toBe false

    expect(@model.isMoveAllowed 1, 4).toBe true

    @model.stage[1][4] = 1
    expect(@model.isMoveAllowed 1, 4).toBe false

  it 'setField sets current player in given tile', ->
    @model.setField 1, 2
    expect(@model.stage[1][2]).toBe 0

    @model.setField 1, 3
    expect(@model.stage[1][3]).toBe 1

  it 'setFields sets last move', ->
    @model.setField 1, 2
    expect(@model.lastMove.x).toBe 1
    expect(@model.lastMove.y).toBe 2

    @model.setField 1, 4
    expect(@model.lastMove.x).toBe 1
    expect(@model.lastMove.y).toBe 4

  it 'setFields changes player', ->
    player = @model.firstPlayer

    @model.setField 1, 2
    expect(@model.firstPlayer).not.toBe player

    @model.setField 1, 2
    expect(@model.firstPlayer).toBe player

  it 'getDirection works correctly', ->
    @model.stage[10][10] = 1
    @model.stage[10][11] = 0

    fields = @model.getDirection 10, 9, 0, 1
    expect(fields).toEqual [-1, 1, 0, -1, -1]

    fields = @model.getDirection 10, 12, 0, -1
    expect(fields).toEqual [-1, 0, 1, -1, -1]

    fields = @model.getDirection 9, 10, 1, 0
    expect(fields).toEqual [-1, 1, -1, -1, -1]

    fields = @model.getDirection 11, 10, -1, 0
    expect(fields).toEqual [-1, 1, -1, -1, -1]

    fields = @model.getDirection 9, 9, 1, 1
    expect(fields).toEqual [-1, 1, -1, -1, -1]

    fields = @model.getDirection 11, 11, -1, -1
    expect(fields).toEqual [-1, 1, -1, -1, -1]

    fields = @model.getDirection 11, 9, -1, 1
    expect(fields).toEqual [-1, 1, -1, -1, -1]

    fields = @model.getDirection 9, 11, 1, -1
    expect(fields).toEqual [-1, 1, -1, -1, -1]

  it 'getDirection does not go outside stage bounds', ->
    fields = @model.getDirection 18, 18, 1, 1
    expect(fields.length).toBeLessThan 5
    expect(fields.length).toBe 2

    fields = @model.getDirection 25, 18, 1, 1
    expect(fields.length).toBe 0

  it 'createDirectionChangers creates all 8 direction changers', ->
    dirChangers =  @model.createDirectionChangers()

    expect(dirChangers.length).toBe 8

    expectedDirChangers = [
      [1, 1],
      [1, 0],
      [1, -1],
      [0, 1],
      [0, -1],
      [-1, 1],
      [-1, 0],
      [-1, -1]
    ]

    for changer in expectedDirChangers
      expect(dirChangers).toContain changer

  it 'didGameEnded detects finished game', ->
    for i in [5..10]
      for j in [7..13]
        @model.stage[i][j] = 0

    @model.lastMove = x: 10, y: 13

    expect(@model.didGameEnded()).toEqual finished: true, player: 0

  it 'didGameEnded returns finished: false if game did not end yet', ->
    @model.lastMove = x: 10, y: 13

    expect(@model.didGameEnded().finished).toEqual false

