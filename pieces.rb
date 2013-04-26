class Piece
  attr_accessor :color, :deltas, :king, :position
  def initialize(color, position)
    @position = position
    @color = color
    @king = false
    @deltas = (self.color == :white) ? [[1,1], [1,-1]] : [[-1,1], [-1,-1]]
  end

  def to_s
    if self.color == :white
      self.king ? 'WWW' : 'WIT'
    else
      self.king ? 'BBB' : 'BLK'
    end
  end

  def position=(position)
    if (:white and position[0] == 7) || (:black and position[0] == 0)
      @king = true
      @deltas = [[1,1], [1,-1], [-1,1], [-1,-1]]
    end
    @position = position
  end




end