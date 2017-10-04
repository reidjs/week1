require_relative 'card'
require_relative 'human_player'
class Board
  attr_accessor :grid, :player, :values
  def initialize(gridsize = 2)
    @grid = Array.new(gridsize) { Array.new(gridsize) }
    @values = random_array(gridsize)
  end

  def populate
    @grid.each_index do |row|
      @grid[row].each_index do |col|
        @grid[row][col] = Card.new(@values.pop)
      end
    end
    @grid
  end

  def random_array(size)
    arr = (0...size).to_a * 2
    arr.shuffle
  end

  def render
    system "clear"
    @grid.each_index do |row|
      @grid[row].each_index do |col|
        print @grid[row][col].to_s
        print " " unless col == @grid[row].length - 1
      end
      print "\n"
    end
  end

  #confusing logic must refactor
  def won?
    !@grid.flatten.any? do |card|
      !card.face_up
    end
  end

  def reveal(guessed_pos)
    card = self[guessed_pos]
    if !card.face_up
      card.reveal
      return card.to_s
    end
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos, value)
    card = @grid[pos[0]][pos[1]]
    card.value = value
  end
end
