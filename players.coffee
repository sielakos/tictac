class @PlayerManager
  constructor: (@gameModel) ->
    @firstPlayer = null
    @secondPlayer = null

  askForMove: (callback) ->
    if @gameModel.firstPlayer
      @firstPlayer.askForMove (tileX, tileY) ->
        callback tileX, tileY, true
    else
      @secondPlayer.askForMove (tileX, tileY) ->
        callback tileX, tileY, false


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
