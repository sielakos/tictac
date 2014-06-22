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