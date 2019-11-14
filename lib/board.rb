# Use this as a sketch of how your Board class could look, you can fill in these
# methods, or make a different class from scratch
require 'tty-table'
require 'colored2'
require 'byebug' # for debugging

class Board
  attr_reader :table, :game_won
  attr_accessor :rows

  def initialize
    @game_won = false
    generate_board
  end

  def generate_board
    rows = []
    6.times do
      rows << []
    end

    rows.each do |r|
      7.times do
        r << empty_string
      end
    end
    @rows = rows
  end

  def empty_string
    "".freeze
  end

  def headers
    [0, 1, 2, 3, 4, 5, 6]
  end

  def print_grid
    @table = TTY::Table.new headers, @rows
    puts @table.render(:ascii, padding: [1, 2, 1, 2])
  end

  def make_move(player, column)
    puts "Placing #{player[:chip]} chip on column: #{column}"
    return false unless validate_placement(column)
    place_chip(player, column)
    update_game_status

    true
  end

  def validate_placement(column)
    has_space = !@rows.detect{ |row| row[column] == empty_string }.nil?

    unless has_space
      puts "No space left in column"
      return false
    end
    true
  end

  def game_ended?
    !!game_won
  end

  private

  def place_chip(chip_opts, column)
    chip  = chip_opts[:chip]
    color = chip_opts[:color]
    @rows.reverse.each do |row|
      if row[column].empty?
        row[column] = chip.to_s.public_send(color)
        break
      end
    end
  end

  def update_game_status
    # TODO: Update game status
  end

  def end_game
    @game_won = true
  end

end
