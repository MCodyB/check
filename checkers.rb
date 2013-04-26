require '/Users/appacademy/Desktop/w2d5/pieces.rb'
require '/Users/appacademy/Downloads/board.rb'

class Game
  attr_accessor :board, :inputs
  def initialize
    @board = Board.new
    @inputs = {'a'=>0, 'b'=>1, 'c'=>2, 'd'=>3,'e'=>4, 'f'=>5, 'g'=>6, 'h'=>7}
  end

  def play
    puts "Welcome to the game"
    white_turn = true
    until over_for_b_or_w?
      self.board.display
      wb = w_or_b(white_turn)
      puts "#{wb}, enter let and num (ex: a1) to choose piece"
      beginning = starting_point
      valid_choice?(beginning, wb)

      slides = slide_moves(beginning)
      jumps = jump_moves(slides, beginning)
      "#{wb}, enter let and num (ex: a1) to choose placement, or separate with a comma or space for multiple jumps"
      ending = placement_moves
    end
  end

  def perform_jump(beginning, ending)
    switch_places(beginning, ending)
    taken(beginning, ending)
  end

  def perform_slide(beginning, ending)
    b_row, b_col = beginning
    e_row, e_col = ending
    @board.grid[e_row][e_col], @board.grid[b_row][b_col] = @board.grid[b_row][b_col], nil
  end

  def display
    self.board.display
  end

  def slide_moves(start)
    s_moves = []
    s = self.board.grid[start[0]][start[1]]
    s.deltas.each do |pair|
      row, col = pair
      p_row, p_col = [s.position[0] + row, s.position[1] + col]
      unless self.board.grid[p_row][p_col]
         s_moves << [p_row, p_col]
      end
    end
    s_moves
  end

  def find_all_jumps(beginning, j_moves)
    all_moves = []
    test_board = self.board.grid.dup
    j_moves.each do |pair|
      all_moves << pair
      until j_moves.size == 0
        test_board.perform_jump(beginning, pair)
        s_moves = test.board[pair[0]][pair[1]].slide_moves
        j_moves = jump_moves(s_moves, pos)
        j_moves.each do
        end
      end
    end

  end

  def jump_moves(slides, pos)
    j_moves = []
    self.board.grid[pos[0]][pos[1]].deltas.each do |pair|
      row, col = pair
      unless slides.include?([pos[0]+row,pos[1]+col]) or @board.grid[pos[0]][pos[1]].color == @board.grid[pos[0]+row][pos[1]+col].color
        j_moves << [pos[0]+row, pos[1]+col]
      end
    end
    j_moves
  end

  def switch_places(beginning, ending)
    b_row, b_col = beginning
    e_row, e_col = ending
    @board.grid[e_row][e_col], @board.grid[b_row][b_col] = @board.grid[b_row][b_col], nil
  end

  def placement_input
    placements = gets.chomp.gsub(',', ' ').split
    placement_array = []
    placements.each do |pair|
      pair = pair.split('')
      placement_array << [self.inputs[pair[0]], pair[1].to_i]
    end
    placement_array
  end

  def starting_point
    beginning = gets.chomp
    beginning = beginning.size == 2 ? beginning.split('') : beginning.gsub(',', ' ').split
    [self.inputs[beginning[0].downcase], (beginning[1].to_i - 1)]
  end

  def valid_choice?(array, wb)
    invalid_entry unless self.board[array[0]][array[1]].color == wb
  end

  def taken(beginning, ending)
    b_row, b_col = beginning
    e_row, e_col = ending
    if (e_row - b_row).abs > 1
      self.board.grid[b_row + (e_row - b_row)][b_col + (e_col - b_col)] = nil
    end
  end

  def over_for_b_or_w?
    w = 0
    b = 0
    self.board.each do |row|
      self.board.each do |col|
        if self.board[row][col].color == :white
          w += 1
        elsif  self.board[row][col].color == :black
          b += 1
        end
      end
    end
    if w == 0
      return :white
    elsif b == 0
      return :black
    end
    false
  end

  def w_or_b(white_turn)
    if white_turn
      "White"
    else
      "Black"
    end
  end

  def invalid_entry
  end
end

=begin
load "/Users/appacademy/Desktop/w2d5/checkers.rb"
brd = Game.new
brd.display
brd.perform_slide([5,0],[3,2])
brd.display
slides = brd.slide_moves([2,1])
=end



