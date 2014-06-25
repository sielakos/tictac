class @HumanPlayer
  constructor: (@ticTac) ->
    @active = false
    @callback = null

    @ticTac.addClickCallback @makeMove

  makeMove: =>
    if @active
      tileX = @ticTac.layer.getTileX @ticTac.game.input.activePointer.worldX
      tileY = @ticTac.layer.getTileY @ticTac.game.input.activePointer.worldY

      @callback tileX, tileY if @callback?
      @active = false

  askForMove: (@callback) ->
    @active = true
