class TicTacGame
  constructor: (@game) ->
    @currentTile = 0
    @simpleGameState = ((-1 for j in [0..20]) for i in [0..20])
    @firstPlayer = true

  preload: =>
    @game.load.image 'tiles', 'tiles.png'

  create: =>
    @game.stage.backgroundColor = "#2d2d2d"

    @createLines()

    @map = @game.add.tilemap();
    @map.addTilesetImage 'tiles'

    @layer = @map.create 'level', 20, 20, 32, 32
    @layer.resizeWorld()

    @game.input.setMoveCallback @updateMarker, this

    @cursors = @game.input.keyboard.createCursorKeys()

    @marker = @game.add.graphics()
    @marker.lineStyle 2, 0x000000, 1
    @marker.drawRect 0, 0, 32, 32

    @pointerMoved = false
    @game.camera.x = 25
    @game.camera.y = 25

  createLines: =>
    @lines = @game.add.graphics()
    @lines.lineStyle 1, 0x00ff00, 1

    for i in [1..19]
      @lines.moveTo 0, i*32
      @lines.lineTo 20*32, i*32

    for i in [1..19]
      @lines.moveTo i*32, 0
      @lines.lineTo i*32, 20*32

  updateMarker: =>
    @pointerMoved = true

    @marker.x = (@layer.getTileX game.input.activePointer.worldX) * 32
    @marker.y = (@layer.getTileY game.input.activePointer.worldY) * 32

    tileX = @layer.getTileX @marker.x
    tileY = @layer.getTileY @marker.y

    if @game.input.mousePointer.isDown
      @setGameField tileX, tileY

  setGameField: (tileX, tileY) =>
    if @simpleGameState[tileX][tileY] == -1
      currentTile = if @firstPlayer then 0 else 1
      @firstPlayer = not @firstPlayer
      @map.putTile currentTile, tileX, tileY, @layer
      @simpleGameState[tileX][tileY] = currentTile

  update: =>
    tileX = @layer.getTileX @marker.x
    tileY = @layer.getTileY @marker.y

    @cursorIsNearEdgeAction tileX, tileY if @pointerMoved

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

game = new Phaser.Game 480, 480, Phaser.AUTO, 'phaser-target', new TicTacGame()
@game = game

