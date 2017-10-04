def load_dictionary
  dictionary = []
  File.open("dictionary.txt").readlines.each do |line|
    dictionary << line.chomp
  end
  dictionary
end

class Game
  attr_accessor :fragment, :dictionary, :players
  def initialize(*new_players)
    @fragment = ""
    @dictionary = load_dictionary
    @players = []
    new_players.each { |player| add_player(player) }

    # @players[0] = @players[@players[0]_idx]
    # @next_player = @players[@players[0]_idx + 1]
  end

  def play_game
    play_round

    if @players[-1].losses >= 5
      puts "#{@players[-1].name} is so bad at this"
    else
      play_game
    end
  end

  def play_round
    round_over = false
    while !round_over
      take_turn(@players[0])
      if in_dictionary?(@fragment)
        puts "#{@players[0].name} is a LOOOOOSER (of the round)!"
        @players[0].losses += 1

        puts "#{@players[0].name}'s letters are #{@players[0].letters}"
        @fragment = ""
        round_over = true
      end
      next_player!
    end
  end

  def add_player(name)
    player = Player.new(name)
    # p player
    @players << player
  end

  def next_player!
    @players.rotate!
  end

  def take_turn(player)
    p "The fragment is '#{fragment}'. Pick a letter, #{@players[0].name}"
    letter = gets.chomp
    if letter.length != 1
      puts "Stop, just stop!"
      return take_turn(player)
    end

    if valid_play?(@fragment + letter)
      @fragment << letter
      return @fragment
    else
      puts "Try harder!"
      return take_turn(player)
    end
  end

  def in_dictionary?(word)
    @dictionary.include?(word)
  end

  def valid_play?(word)
    flag = false
    @dictionary.any? do |werd|
      # p werd[0..word.length - 1]
      flag = true if (werd[0..word.length - 1] == word)
    end


    flag
  end

end

class Player
  attr_accessor :name, :losses

  def initialize(name)
    @name = name
    @losses = 0
  end


  def letters
    "GHOST"[0...@losses]
  end
  # def add_letter
  #  letters = "GHOST".split
  #  @losses << letters.shift
  #  if letters.empty?
  #    "DAAAANG, lololololooooooooosssssseeeerrrr"
  #  end
  # end
end

class AiPlayer

  attr_accessor :fragment

  def initialize(name)
    @possible_words = load_dictionary
  end

  def pick_letter(fragment)
    options = @possible_words.map do |word|
        word[0..fragment.length]
      end
  end

  def filter_words(fragment)
    filtered = @possible_words.select do |word|
      word[0..fragment.length - 1] == fragment
    end

    filtered
  end



end

robot = AiPlayer.new("HAl")
p robot.filter_words("ca")
# ghost = Game.new('bob', 'george')
# ghost.play_game
# p ghost.fragment
# p ghost.valid_play?("ca")
# ghost.load_dictionary
# p ghost.dictionary.length
