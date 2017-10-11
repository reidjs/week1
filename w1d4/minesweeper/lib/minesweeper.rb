require_relative 'board'


class MinesweeperGame
  attr_accessor :board
  def initialize(board = Board.new)
    @board = board
    @turn_count = 0
    @force_quit = false
  end

  def play_round
    until win? || lose? || @force_quit
      @board.render
      puts "Please pick a position."
      # puts "Oops, that's not a valid position."
      # puts "Please pick another position."
      pos = get_position
      @board.render
      # selected_tile = @board[pos]
      @board.reveal(pos)
      #mine check is handled by the board
      # if @board.is_mine?(selected_tile)
      #   @board.mine_found!
      # end
      @turn_count += 1
    end
    if win?
      puts "You win!"
    else
      puts "You lost!"
    end
    #show final game state
    @board.render
  end

  def win?
    @turn_count == 4
  end

  def lose?
    @board.bomb_revealed?
  end

  def get_position
    # input = gets.chomp.split(",").map(&:to_i)
    # p input
    # input
    @board.get_position
  end



  def valid_position?(pos)
    return false if pos.length != 2
    # return false if !pos.is_a?(Array)
    return true unless @board[pos] == false ||
                       @board[pos].revealed
    false
  end

end
if __FILE__ == $PROGRAM_NAME
  game1 = MinesweeperGame.new
  game1.board.populate_mines
  game1.play_round
end
