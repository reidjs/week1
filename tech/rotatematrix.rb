#given NxN array of 4byte pixels, rotate by 90 degrees
matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
rotate90 = []
matrix.each_index do |row|
  t = []
  matrix[row].each_index do |col|
    t << matrix[col][row]
  end
  rotate90 << t
end
p rotate90
#challenge: do rotation in place (without duplicating array)
