// Generated by CoffeeScript 1.7.1
(function() {
  describe('SimpleAiPlayer', function() {
    beforeEach(function() {
      this.model = new TicTacToeGameModel(10);
      return this.ai = new SimpleAiPlayer(this.model.clone, 1);
    });
    return it('calculates points with changed value correctly', function() {
      var calculatedPoints, point, somePoints, _i, _len, _results;
      this.model.lastMove = {
        x: 1,
        y: 5
      };
      somePoints = [
        {
          x: 0,
          y: 4
        }, {
          x: 1,
          y: 4
        }, {
          x: 2,
          y: 6
        }, {
          x: 4,
          y: 2
        }
      ];
      calculatedPoints = this.ai.getPoints(this.model);
      _results = [];
      for (_i = 0, _len = somePoints.length; _i < _len; _i++) {
        point = somePoints[_i];
        _results.push(expect(calculatedPoints).toContain(point));
      }
      return _results;
    });
  });

}).call(this);
