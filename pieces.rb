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

  def perform_moves!(move_sequence)
  end

  def valid_move_seq?
  end

  def perform_moves
    valid_move_seq?
    perform_moves!
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
      s_moves = return_adjacent_hash(s_moves, [p_row, p_col])
      unless board[p_row][p_col]
         s_moves[:moves] << [p_row, p_col]
      else
         s_moves[:taken] << [p_row, p_col] if board[p_row][p_col].color != self.color
      end
    end
    s_moves
  end



  def jump_moves(slide_moves)
    j_moves = {:landing => [], :to_take => []}
    slide_moves[:taken].each do |place|
      row, col = place
      if board[row][col].color != self.color
        row_dtrmnt = (row - self.position[0])
        col_dtrmnt = (col - self.position[1])
        unless board[row + row_dtrmnt][col + col_dtrmnt]
          j_moves[:landing] << [(row + row_dtrmnt),(col + col_dtrmnt)]
          j_moves[:taken] << [row, col]
        end
      end
    end
    j_moves
  end


end