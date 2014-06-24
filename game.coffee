class TicTacGame
  constructor: (@game) ->
    @ticTacModel = new TicTacToeGameModel 20
    @clickCallbacks = []

  addClickCallback: (callback) =>
    @clickCallbacks.push callback
    callback.clickCallbackId = Math.random()

  removeCallback: (callback) =>
    newCallbacks = []
    for element in @clickCallbacks
      if element.clickCallbackId != callback.clickCallbackId
        newCallbacks.push element

    @clickCallbacks = newCallbacks

  preload: =>
    @game.load.image 'tiles', 'tiles.png'

  create: =>
    @createPlayers()
    @createRestartCallback()

    @game.stage.backgroundColor = "#2d2d2d"

    @createLines()

    @map = @game.add.tilemap();
    @map.addTilesetImage 'tiles'

    @layer = @map.create 'level', @ticTacModel.mapSize, @ticTacModel.mapSize, 32, 32
    @layer.resizeWorld()

    @game.input.setMoveCallback @onMove, this

    @cursors = @game.input.keyboard.createCursorKeys()

    @marker = @game.add.graphics()
    @marker.lineStyle 2, 0x000000, 1
    @marker.drawRect 0, 0, 32, 32

    @pointerMoved = false
    @game.camera.x = 25
    @game.camera.y = 25

    style =
      font: "35pt Arial"
      fill: "#b0ffb0"
      align: "center"
    @endText = game.add.text @game.world.centerX - 200, @game.world.centerY - 50, '', style
    @endText.visible = false

  createPlayers: =>
    @playerManager = new PlayerManager @ticTacModel
    @playerManager.firstPlayer = new HumanPlayer this
    @playerManager.secondPlayer = new HumanPlayer this

  createRestartCallback: =>
    active = false
    @addClickCallback =>
      if not active and not @ticTacModel.gameInProgress
        active = true
      else if active
        @restart()
        active = false

  createLines: =>
    @lines = @game.add.graphics()
    @lines.lineStyle 1, 0x00ff00, 1

    for i in [1..@ticTacModel.mapSize]
      @lines.moveTo 0, i*32
      @lines.lineTo @ticTacModel.mapSize*32, i*32

    for i in [1..@ticTacModel.mapSize]
      @lines.moveTo i*32, 0
      @lines.lineTo i*32, @ticTacModel.mapSize*32

  onMove: =>
    @updateMarker()

    if @game.input.mousePointer.isDown
      callback() for callback in @clickCallbacks

  updateMarker: ->
    @pointerMoved = true

    @marker.x = (@layer.getTileX @game.input.activePointer.worldX) * 32
    @marker.y = (@layer.getTileY @game.input.activePointer.worldY) * 32

  setGameField: (tileX, tileY) =>
    if @ticTacModel.isMoveAllowed tileX, tileY
      @ticTacModel.setField tileX, tileY
      @map.putTile @ticTacModel.getTileNumber(), tileX, tileY, @layer

      {finished, player} = @ticTacModel.didGameEnded()
      @gameEnded player if finished

  gameEnded: (player) ->
    @endText.text = 'Game Over,\n'
    if player == 0
      @endText.text += 'first player'
    else
      @endText.text += 'second player'

    @endText.text += ' won!'
    @endText.visible = true

  restart: =>
    @ticTacModel.restart()
    @map.fill(2, 0,0, @ticTacModel.mapSize, @ticTacModel.mapSize, @layer)
    @endText.visible = false

  update: =>
    tileX = @layer.getTileX @marker.x
    tileY = @layer.getTileY @marker.y

    @cursorIsNearEdgeAction tileX, tileY if @pointerMoved

    if @ticTacModel.gameInProgress
      @playerManager.askForMove @setGameField

    if @cursors.left.isDown
      @game.camera.x -= 4
    else if @cursors.right.isDown
      @game.camera.x += 4
    else if @cursors.up.isDown
      @game.camera.y -= 4
    else if @cursors.down.isDown
      @game.camera.y += 4

  cursorIsNearEdgeAction: (tileX, tileY) ->
    startX = @layer.getTileX @game.camera.x
    startY =@layer.getTileY @game.camera.y
    endX = @layer.getTileX @game.camera.x + @game.camera.width
    endY = @layer.getTileY @game.camera.y + @game.camera.height

    if tileX <= (startX + 2)
      @game.camera.x -= 4

    if tileX >= (endX - 2)
      @game.camera.x += 4

    if tileY <= (startY + 2)
      @game.camera.y -= 4

    if tileY >= (endY - 2)
      @game.camera.y += 4

game = new Phaser.Game 640, 640, Phaser.AUTO, 'phaser-target', new TicTacGame()
@game = game

