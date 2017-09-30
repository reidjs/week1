#optimized for eight queens problem 
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
