require 'byebug'
class Board
  attr_accessor :grid, :queen_locations
  def initialize(size = 5)
    @queen_locations = []
    @grid = []
    @h = {}
    # default_size = 5
    size.times do
      @grid << Array.new(size, 0)
    end
  end

  def insert_queen(row, col)
    @queen_locations << [row, col]
    @grid[row][col] = 1
  end

  #specify the row and column of the queen, then this will return true
  #if there's another one.
  def other_queen_in_row?(row, col)
    left = @grid[row][0, col]
    right = @grid[row][col + 1..-1]
    if left.include?(1) || right.nil? || right.include?(1)
      return true
    end
    false
  end

  def other_queen_in_col?(row, col)
    other_cells_in_col = []
    @grid.each_with_index do |r, i|
      if row != i
        other_cells_in_col << r[col]
      end
    end
    other_cells_in_col.include?(1) ? true : false
  end

  def other_queen_in_any_diag?(row, col)
    a = other_queen_in_diag?(row, col, 1, 1)
    b = other_queen_in_diag?(row, col, 1, -1)
    c = other_queen_in_diag?(row, col, -1, -1)
    d = other_queen_in_diag?(row, col, -1, 1)
    a || b || c || d
  end

  def other_queen_in_diag?(row, col, rowdir, coldir)
    next_row = row + rowdir
    next_col = col + coldir
    # p "#{next_row}, #{next_col}"
    if next_row < 0 || next_row >= @grid.length
      return false
    end
    if next_col < 0 || next_col >= @grid.length
      return false
    end
    return true if @grid[next_row][next_col] == 1
    other_queen_in_diag?(next_row, next_col, rowdir, coldir)
  end

  def other_queen_in_any_direction?(row, col)
    a = other_queen_in_any_diag?(row, col)
    b = other_queen_in_col?(row, col)
    c = other_queen_in_row?(row, col)
    a || b || c
  end

  def check_solution
    @queen_locations.each do |pos|
      row = pos[0]
      col = pos[1]
      return false if other_queen_in_any_direction?(row, col)
    end
    true
  end

  def render_chessboard
    print " "
    ('a'..'h').to_a.each do |l|
      print " " + l + " "
    end
    print "\n"
    i = 8
    @grid.each do |row|
      print i
      p row
      i -= 1
    end
  end

  def render
    print " "
    (0...@grid.length).to_a.each do |l|
      print " " + l.to_s + " "
    end
    print "\n"
    i = 0
    @grid.each do |row|
      print i
      p row
      i += 1
    end
  end
end

'''
8 queens and 8 rows means there MUST be one queen on every row. If
1. Place a queen at a starting position
This blocks off the rows and columns associated with that starting position so the field of possibilities is smaller
2. Go to the next row
3. Try the first available space in this row and Place queen there
4. Go to next row
5. Try the first available space in this row and place queen there
If you find there is a row that placing a queen is impossible REJECT THIS SOLUTION.
etc...
Now go back to step two and repeat 3..end
EVERY ROW and EVERY COL must be filled
'''
class Algorithm
  attr_accessor :board
  def initialize
    @board = Board.new
    @starting_positions = []
    @startrow = 0
    @startcol = 2
    @solutions = []
  end

  # def solve_helper(row = 0, board = Board.new)
  #   if row == @board.grid.length
  #     @solutions << @board
  #     solve(0)
  #   end
  #   possible_cols = find_possible_queen_placements_on_row(row)
  #   solution_space << possible_cols
  #   while !solution_space.empty?
  #     @board.insert_queen(row, possible_cols.pop)
  #     solve(row + 1, board)
  #   end
    # @board.insert_queen(row, possible_cols[0])
    # #take snapshot of board state?
    # # row += 1
    # solve(row + 1)
    # @board.render
  # end

  # def solve(row = 0, queens = 8)
  #   @board.insert_queen(row, pick_col)
  #   solve(row + 1, queens - 1)
  #
  # end

  def solve
    #starting with empty board
    #place a queen at leftmost, non-attempted spot
    #record this attempt as [0]
    #advance to next row
    #place a queen at leftmost, legal, non attempted spot
    #record as [0 -> 2]
    #advance to next row
    #place queen at leftmost legal, etc.
    #[0] next row
    #look for first possible column (2)
    #[0, 2] next row
    #look for first possible column (4)
    #[0, 2, 4] next row
    #look for first possible column (1)
    #[0, 2, 4, 1]
    #look for first possible column (3)
    #[0, 2, 4, 1, 3] done (add to solutions, then go to previous row)

    #[0, 2, 4, 1] no more possible columns, false (go to previous row)
    #[0, 2, 4] false
    #[0, 2] false
    #[0, 3]
    #[0, 3, 1]
    #[0, 3, 1]

  end

  #input: array of cols. negative one means no queen in row
  #output: board with queens placed

  def array_to_queen_locations(arr, board_size = 5)
    board = Board.new(board_size)
    arr.each_with_index do |col, row|
      if col >= 0
        board.insert_queen(row, col)
      end
    end
    # board.render
    board
  end

  def queen_locations_to_array(board)
    arr = []
    board.grid.each do |row|
      flag = false #to keep track of a queen placed in row. false = no queen
      row.each_index do |col|
        if row[col] == 1
          arr << col
          flag = true #queen placed in row
        end
        next if flag
        if col == row.length - 1 && flag == false
          arr << -1
        end
      end
    end
    arr
  end

  def next_iter(board, start_col = 0)
    arr = queen_locations_to_array(board)
    # board = array_to_queen_locations(arr)
    next_row = next_row_without_queen(arr)
    # byebug if next_row.nil?
    backtrack_until_additional_starting_col(arr,arr.length) if next_row.nil?
    next_col = next_untested_column(arr, next_row, start_col)
    # previous_iter(arr) if next_col.nil?
    # byebug
    # if next_row.nil? && arr.length == board.grid.length#there are no empty rows
    #   p "DONE"
    #   @solutions << arr
    #   previous_iter(arr)
    # end
    # next_col = find_next_possible_queen_placements_on_row(board, next_row, start_col)
    # if next_col.nil?
    #   previous_iter(arr)
    # end

    board.insert_queen(next_row, next_col)
    board
  end

  def next_untested_column(arr, row, start_col)
    board = array_to_queen_locations(arr)
    find_next_possible_queen_placements_on_row(board, row, start_col)
  end

  def next_row_without_queen(arr)
    arr.index(-1)
  end

  def backtrack_until_additional_starting_col(arr, start_row)
    byebug
    board = array_to_queen_locations(arr)
    row = start_row
    # col = board[row].index(1)
    while next_col.nil?
      row -= 1
      col = board.grid[row].index(1) + 1
      next_col = find_next_possible_queen_placements_on_row(board, row, col)
    end
    next_col
  end

  def previous_iter(arr)
    byebug
    start_col = arr.pop + 1
    board = array_to_queen_locations(arr)
    next_iter(board, start_col)
  end

  #input: row number
  #scans board for other queens to reject cols that have a queen attached
  #make sure there is not already a queen on this row or it will return a blank array
  #output: array of possible spaces to place queen on this particular row

  def find_next_possible_queen_placements_on_row(board, row, start_col = 0)
    arr = []
    col = start_col
    while col < board.grid[row].length
      return col if !board.other_queen_in_any_direction?(row, col)
      col += 1
    end
    # board.grid[row].each_index do |col|
    #   arr << col if !board.other_queen_in_any_direction?(row, col)
    # end
    # arr
    nil
  end


end

# x = Board.new
solver = Algorithm.new
# solver.board.render
empty_board = Board.new
board = solver.next_iter(empty_board)
board.render
solver.next_iter(board)
board.render
solver.next_iter(board)
board.render
solver.next_iter(board)
board.render
solver.next_iter(board)
board.render
solver.next_iter(board)
board.render


# board.render
# solver.solve
# solver.board.render
# x.insert_queen(2, 5)
# x.insert_queen(0, 5)
# x.insert_queen(5, 5)
# x.insert_queen(6, 7)
# x.insert_queen(0, 4)
# # p x.other_queen_in_any_diag?(1, 5)
# x.render
# p x.check_solution

if $PROGRAM_NAME == __FILE__
  puts "stuff"
end
