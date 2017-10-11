require 'rspec'
require 'minesweeper'

describe "Board" do
  let(:grid) { Array.new(3) {Array.new(3) { Tile.new } } }
  subject(:board) { Board.new(grid) }
  describe "grid" do
    it "sets the grid size to the grid passed in" do
      expect(board.grid.length).to eq(3)
    end
    # context 'hard mode' do
    #   it "increases the number of mines on the board" do
    #     subject(:board) { Board.new(grid) }
    #   end
    # end
    describe "#populate_mines" do
      it "creates the correct number of mines" do
        expect(board.populate_mines.length).to eq(board.number_of_mines)
      end
    end

  end

end

describe "Game" do
  subject(:game) { MinesweeperGame.new }
  describe "lose" do
    it "ends game if mine revealed" do
      pos = [0,0]
      game.board[pos].set_as_mine!
      game.board.reveal(pos)
      expect(game.lose?).to be true
    end
  end
end
