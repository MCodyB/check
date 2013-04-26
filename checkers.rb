class Game

end

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
      'wit'
    else
      'blk'
    end
  end

  def return_moves
    @
  end
end

class Board
  attr_accessor :grid
  def initialize
    @grid = Array.new(8) {Array.new(8)}
    place_pieces
    #place_blacks(@grid)
  end

  def display
    self.grid.each do |row|
      temp = []
      row.each do |el|
        if el
          temp.push(el)
        else
          temp.push(' ')
        end
      end
      puts "#{temp}"
    end
  end

  private
  def place_pieces#(grid)
    put = true
    (0..7).each do |row|
      put = !put
      (0..7).each do |col|
        if row <= 2
         if put
           self.grid[row][col] = Piece.new(:white, [row,col])
         end
         put = !put
        elsif row >= 5
          if put
            self.grid[row][col] = Piece.new(:black, [row,col])
          end
          put = !put
        end
      end
    end
  end

end