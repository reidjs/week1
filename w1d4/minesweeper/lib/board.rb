require_relative 'tile'
require_relative 'cursor'
require 'colorize'
require 'byebug'
class Board
  attr_accessor :grid, :display
  attr_reader :number_of_mines

  def initialize(grid = self.create_grid)
    @grid = grid
    @bomb_revealed = false
    @number_of_mines = 6
    @display = Display.new(self)
    # @cursor = Cursor.new([0,0], self)
  end

  def create_grid
    Array.new(9) { Array.new(9) { Tile.new } }
  end

  def reveal(pos)
    row, col = pos
    if !is_mine?(pos)
      neighbor_mines = count_neighbor_mines(pos)
      # @grid[pos].reveal(neighbor_mines)
      self[pos].reveal(neighbor_mines)
    else
      mine_found!
      byebug
      @grid[row][col].reveal(neighbor_mines)
      # @self[pos].reveal(neighbor_mines)
    end
    true
  end

  def [](pos)
    row, col = pos
    value = @grid[row][col]
    # value
    value.nil? ? false : value
  end

  def valid_position?(pos)
    true
  end
  def render
    @display.render
  end
  # def render
  #   # bg_color = :light_black
  #   print "Your board looks like this—\n".colorize(:blue)
  #   print "  #{(0...9).to_a.join(" ")}"
  #   puts
  #   @grid.each_with_index do |row, i|
  #     print "#{i} "
  #     row.each_with_index do |col, j|
  #       pos = [i,j]
  #       is_cursor_pos?(pos) ? bg_color = :light_black : bg_color = :white
  #       print "#{col.show} ".colorize(:background_color => bg_color)
  #     end
  #     print "\n"
  #   end
  # end
  #
  # def is_cursor_pos?(pos)
  #   @cursor_pos == pos
  # end



  def populate_mines
    mine_positions = []
    while mine_positions.length < @number_of_mines
      rand_x = rand(@grid.length)
      rand_y = rand(@grid.length)
      pos = [rand_x, rand_y]
      if !mine_positions.include?(pos)
        puts "Placing a mine at #{pos}"
        self[pos].set_as_mine!
        mine_positions << pos
      end
    end
    mine_positions
  end



  def []=(pos, value)
    @grid[pos[0]][pos[1]].value = value
  end

  def count_neighbor_mines(pos)
    row, col = pos
    count = 0

    above = @grid[row-1][col-1..col+1]
      .select { |tile| !tile.nil? && tile.mine? }
    count += above.length

    left = @grid[row][col-1]
    right = @grid[row][col+1]
    count += 1 if (!left.nil? && left.mine?)
    count += 1 if (!right.nil? && right.mine?)

    below = @grid[row+1][col-1..col+1]
      .select { |tile| !tile.nil? && tile.mine? }
    count += below.length

    count
  end

  def is_mine?(pos)
    return false if pos.nil?
    # row, col = pos
    self[pos].value == 'X'
  end
  def check_at_cursor_position
    @display.enter_key_pressed
    # @cursor.enter_key_pressed
  end

  def bomb_revealed?
    @bomb_revealed
  end

  def mine_found!
    @bomb_revealed = true
  end

  def get_position
    @display.get_position
  end

  def force_quit!
    @bomb_revealed = true
  end

end

#gets cursor input and sends to board
class Display
  attr_accessor :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def enter_key_pressed
    @cursor.enter_key_pressed
  end

  def render
    # bg_color = :light_black
    puts "#{@cursor_pos}"
    print "Your board loooooks like this—\n".colorize(:background => :blue)
    print "  #{(0...9).to_a.join(" ")}"
    puts
    #should not need to access board.grid here!
    @board.grid.each_with_index do |row, i|
      print "#{i} "
      row.each_with_index do |col, j|
        pos = [i,j]
        is_cursor_pos?(pos) ? bg_color = :light_black : bg_color = :white
        print "#{col.show} ".colorize(:background => bg_color)
      end
      print "\n"
    end
  end

  def is_cursor_pos?(pos)
    @cursor.cursor_pos == pos
  end

  def get_position
    get_input
    @cursor.cursor_pos
  end

  def get_input
    @cursor.get_input
  end


end


if __FILE__ == $PROGRAM_NAME
  my_board = Board.new
  # byebug
  pos = [4, 5]
  pos2 = [3, 7]
  # my_board[pos] = 1
  # my_board.render
  my_board.populate_mines
  my_board.reveal(pos)
  p my_board[pos2].revealed
  my_board.render
end
# p my_board.count_neighbor_mines(pos)
