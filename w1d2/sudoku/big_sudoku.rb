#TO DO: Figure out how to render the board
#TO DO: Take player input
#TO DO: Check if entire puzzle solved
#TO DO: Populate with valid sample numbers based on difficulty

require 'byebug'
class Board
  attr_accessor :grids
  def initialize(gridsize = 3)
    @grids = []
    i = 0
    while i < gridsize**2
      grid = Array.new(gridsize) {Array.new(gridsize, 0)}
      @grids << grid
      i += 1
    end
  end

  def render_grids
    i = 0
    while i < @grids.length
      # p @grids[i]
      @grids[i].each_index do |row|
        # p row
        @grids[i][row].each_index do |col|
          print @grids[i][row][col]
        end
        # print "\n"
      end
      # print "\n" if i % 3 == 0
      i += 1
    end
    # @grids.each_with_index do |grid, i|
    #   print @grids[i]
    #   print "\n" if i % 3
    # end
  end

  def render_grid(grid)
    grid.each_index do |row|
      grid[row].each_index do |col|
        print grid[row][col]
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
    @board.grids.each do |grid|
      won_grid?(grid)
    end
  end

  def won_grid?(grid)
    target_sum = (1..grid.length).reduce(:+)
    grid.each_index do |row|
      row_sum = grid[row].reduce(:+)
      return false if row_sum != target_sum
      return false if grid[row].uniq.length != grid[row].length
    end
    rotated = grid.transpose
    rotated.each do |col|
      col_sum = col.reduce(:+)
      return false if col_sum != target_sum
      return false if col.uniq.length != col.length
    end
    true
  end

end

winning_board_test = [[1,2,3],[2,3,1],[3,1,2]]
x = Game.new(Board.new)
x.board.render_grids
# x = Game.new(Board.new(winning_board_test))

# x.board.render
# p x.won?
