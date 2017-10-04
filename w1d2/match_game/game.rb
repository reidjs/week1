#!/usr/bin/env ruby
#TO DO: Take command line arguments
#TO DO: Add AI Player

require_relative 'board'
require_relative 'human_player'
require 'byebug'
class Game
  attr_accessor :board, :num_turns
  def initialize(board, player = HumanPlayer.new("bob"))
    @board = board
    @player = player
    @num_turns = 0
  end

  def parse_string(input)
    pos = []
    pos << input[0].to_i
    pos << input[-1].to_i
    # p pos
  end

  def prompt
    input = @player.prompt
    parse_string(input)
  end

  def take_turn
    pos = prompt
    card = make_guess(pos)
    if card.nil?
      puts "Invalid move!"
      return take_turn
    else
      card.reveal
      @board.render
    end
    if @previous_card.nil?
      @previous_card = card
      return card.value
    end
    if card.value != @previous_card.value
      @board.render
      sleep(2)
      card.hide
      @previous_card.hide
    end
    @previous_card = nil
  end

  def play
    until @board.won?
      @board.render
      take_turn
    end
    @board.render
    puts "Winner!"
  end

  def make_guess(pos)
    return nil if @board[pos].face_up
    @board[pos]
  end
end

if $PROGRAM_NAME == __FILE__
  x = Game.new(Board.new(2), HumanPlayer.new("bob"))
  x.board.populate
  x.play
end
