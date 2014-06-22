// Generated by CoffeeScript 1.7.1
(function() {
  this.TicTacToeGameModel = (function() {
    function TicTacToeGameModel(mapSize) {
      var i, j;
      this.mapSize = mapSize != null ? mapSize : 20;
      this.stage = (function() {
        var _i, _ref, _results;
        _results = [];
        for (i = _i = 0, _ref = mapSize - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
          _results.push((function() {
            var _j, _ref1, _results1;
            _results1 = [];
            for (j = _j = 0, _ref1 = mapSize - 1; 0 <= _ref1 ? _j <= _ref1 : _j >= _ref1; j = 0 <= _ref1 ? ++_j : --_j) {
              _results1.push(-1);
            }
            return _results1;
          })());
        }
        return _results;
      })();
      this.firstPlayer = true;
      this.lastMove = {
        x: Math.round(mapSize / 2),
        y: Math.round(mapSize / 2)
      };
    }

    TicTacToeGameModel.prototype.isMoveAllowed = function(tileX, tileY) {
      return (this.isWithinStageBounds(tileX, tileY)) && this.stage[tileX][tileY] === -1;
    };

    TicTacToeGameModel.prototype.isWithinStageBounds = function(tileX, tileY) {
      return tileX >= 0 && tileY >= 0 && tileX < this.mapSize && tileY < this.mapSize;
    };

    TicTacToeGameModel.prototype.setField = function(tileX, tileY) {
      this.stage[tileX][tileY] = this.firstPlayer ? 0 : 1;
      this.firstPlayer = !this.firstPlayer;
      return this.lastMove = {
        x: tileX,
        y: tileY
      };
    };

    TicTacToeGameModel.prototype.getTileNumber = function() {
      if (this.firstPlayer) {
        return 0;
      } else {
        return 1;
      }
    };

    TicTacToeGameModel.prototype.isGameFinished = function() {};

    TicTacToeGameModel.prototype.getDirection = function(x, y, dirX, dirY) {
      var fields, i, _i;
      fields = [this.stage[x][y]];
      for (i = _i = 1; _i <= 4; i = ++_i) {
        x += dirX;
        y += dirY;
        if (this.isWithinStageBounds(x, y)) {
          fields.push(this.stage[x][y]);
        }
      }
      return fields;
    };

    return TicTacToeGameModel;

  })();

}).call(this);
