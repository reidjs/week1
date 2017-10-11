require "io/console"

KEYMAP = {
  " " => :space,
  "h" => :left,
  "j" => :down,
  "k" => :up,
  "l" => :right,
  "w" => :up,
  "a" => :left,
  "s" => :down,
  "d" => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c,
}

MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}

class Cursor

  attr_reader :cursor_pos, :board, :enter_key_pressed

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @board = board
    @enter_key_pressed = false
  end

  def get_input
    @enter_key_pressed = false 
    key = KEYMAP[read_char]
    handle_key(key)
  end

  private

  def read_char
    STDIN.echo = false # stops the console from printing return values

    STDIN.raw! # in raw mode data is given as is to the program--the system
                 # doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr # STDIN.getc reads a one-character string as a
                             # numeric keycode. chr returns a string of the
                             # character represented by the keycode.
                             # (e.g. 65.chr => "A")

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil # read_nonblock(maxlen) reads
                                                   # at most maxlen bytes from a
                                                   # data stream; it's nonblocking,
                                                   # meaning the method executes
                                                   # asynchronously; it raises an
                                                   # error if no data is available,
                                                   # hence the need for rescue

      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true # the console prints return values again
    STDIN.cooked! # the opposite of raw mode :)

    return input
  end

  def handle_key(key)
    case key
    when :up
      update_pos(MOVES[key])
    when :down
      update_pos(MOVES[key])
    when :left
      update_pos(MOVES[key])
    when :right
      update_pos(MOVES[key])
    when :escape
      force_quit!
    when :return
      @enter_key_pressed = true
    else
      return
    end
  end

  def force_quit!
    @board.force_quit!
  end

  def update_pos(diff)
    @cursor_pos
    i = 0
    result = []
    while i < @cursor_pos.length
      result << @cursor_pos[i] + diff[i]
      i += 1
    end
    if valid_position?(result)
      @cursor_pos = result
    else
      @cursor_pos
    end
  end

  def valid_position?(pos)
    @board.valid_position?(pos)
  end


end
