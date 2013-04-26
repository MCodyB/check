require './pieces'
require './board'

class Game
  attr_accessor :board
  def initialize
    @board = Board.new
  end

  def perform_jump(beginning, ending)
    b_row, b_col = beginning
    e_row, e_col = ending
    self.board[b_row][b_col]
    j_moves = j_moves()
  end

  def perform_slide(beginning, ending)
    switch_places(beginning, ending)
  end

  private
  def switch_places(beginning, ending)
    b_row, b_col = beginning
    e_row, e_col = ending
    self.board[e_row][e_col], self.board[b_row][b_col] = self.board[b_row][b_col], nil
  end
end

=begin

=end



