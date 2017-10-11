class Tile
  attr_accessor :value, :revealed, :selected
  def initialize(revealed = false)
    @revealed = revealed
    @value = 0
  end

  def mine?
    @value == "X"
  end

  def reveal(neighbor_mines)
    p "Tile revealed"
    mine? ? @value = "X" : @value = neighbor_mines
    @revealed = true
  end

  def set_as_mine!
    @value = "X"
  end

  def show
    if @revealed
      return @value
    else
      return "\#"
    end
  end
end
