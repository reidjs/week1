class Board
  attr_accessor :grid
  def initialize(gridsize = 3)
    @grid = Array.new(gridsize) {Array.new(gridsize, 0)}
  end

  def render
    @grid.each_index do |row|
      @grid[row].each_index do |col|
        print @grid[row][col]
      end
      print "\n"
    end
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos, value)
    @grid[pos[0]][pos[1]] = value
  end
end

#class play

class Game
  attr_accessor :board
  def initialize(board = Board.new)
    @board = board
  end

  def won?
    sudoku = @board.grid
    target_sum = (1..sudoku.length).reduce(:+)
    sudoku.each_index do |row|
      row_sum = sudoku[row].reduce(:+)
      return false if row_sum != target_sum
      return false if sudoku[row].uniq.length != sudoku[row].length
    end
    rotated = sudoku.transpose
    rotated.each do |col|
      col_sum = col.reduce(:+)
      return false if col_sum != target_sum
      return false if col.uniq.length != col.length
    end
    true
  end

end

winning_board_test = [[1,2,3],[2,3,1],[3,1,2]]
x = Game.new(Board.new(winning_board_test))

x.board.render
p x.won?
