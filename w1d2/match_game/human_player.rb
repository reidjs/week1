class HumanPlayer
  attr_accessor :name
  def initialize(name)
    @name = name
  end

  def prompt
    puts "Enter a pos #,# >>"
    gets.chomp
  end


end
