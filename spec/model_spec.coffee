describe 'TicTacToeGameModel', ->
  beforeEach ->
    @model = new TicTacToeGameModel 20

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