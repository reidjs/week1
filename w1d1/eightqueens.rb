require 'byebug'
require_relative 'chessboard'

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

  #input: array of cols. negative one means no queen in row
  #output: board with queens placed

  def array_to_board(arr, board_size = 5)
    board = Board.new(board_size)
    arr.each_with_index do |col, row|
      if col >= 0
        board.insert_queen(row, col)
      end
    end
    # board.render
    board
  end

  def board_to_array(board)
    arr = []
    board.grid.each do |row|
      flag = false #to keep track of a queen placed in row. false = no queen
      row.each_index do |col|
        if row[col] == 1
          arr << col
          flag = true #queen placed in row
        end
        next if flag
        # if col == row.length - 1 && flag == false
        #   arr << -1
        # end
      end
    end
    arr
  end

  def solve(board)
    next_queen_pos = next_iter(board)
    if next_queen_pos.nil?
      board = backtrack(board, board.grid.length-1)
    else
      board.insert_queen(next_queen_pos[0], next_queen_pos[1])
    end
    board.render
    board
  end

  def backtrack(board, row)
    arr = board_to_array(board)
    value = arr.pop
    board = array_to_board(arr)
    if next_untested_column(arr, row, value + 1).nil?
      backtrack(board, row - 1)
    end
    return board
    # next_untested_column(arr, row, value)
    # #get the last rows queen col
    # previous_row_queen_col = arr.last
  end

  def next_iter(board, start_col = 0)
    arr = board_to_array(board)
    next_row = next_row_without_queen(arr)
    return nil if next_row.nil?
    next_col = next_untested_column(arr, next_row, start_col)
    return [next_row, next_col]
  end

  def next_untested_column(arr, row, start_col)
    board = array_to_queen_locations(arr)
    find_next_possible_queen_placements_on_row(board, row, start_col)
  end

  def next_row_without_queen(arr)
    arr.index(-1)
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
b = solver.solve(empty_board)
b = solver.solve(b)
b.render
b = solver.solve(b)
b = solver.solve(b)
b = solver.solve(b)



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
