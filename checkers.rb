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
      self.king ? 'WWW' : 'wit'
    else
      self.king ? 'BBB' : 'blk'
    end
  end

  def position=(position)
    if (:white and position[0] == 7) || (:black and position[0] == 0)
      @king = true
      @deltas = [[1,1], [1,-1], [-1,1], [-1,-1]]
    end
    @position = position
  end


  def slide_moves
    s_moves = {:moves => [], :taken => []}
    self.deltas.each do |pair|
      row, col = pair
      p_row, p_col = [self.position[0] + row, self.position[1] + col]
      unless board[p_row][p_col]
         s_moves[:moves] << [p_row, p_col]
       else
         s_moves[:taken] << [p_row, p_col]
      end
    end
    s_moves
  end

  def jump_moves(slide_moves)
    j_moves = {:landing = [], :to_take =[]}
    slide_moves[:taken].each do |place|
      row, col = place
      if board[row][col].color != self.color
        if board
      end
    end
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
    row_indicator = 'a'
    self.grid.each do |row|
      temp = []
      row.each do |el|
        if el
          temp.push(el)
        else
          temp.push(' ')
        end
      end
      puts "#{row_indicator}|#{temp}"
      row_indicator = row_indicator.next
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