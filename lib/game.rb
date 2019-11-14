require_relative 'board'

# This class is for initializing and running a game. It will
# need a new board and a way to keep track of who is the
# current player. The rest is up to you:
class Game

  # TODO: encapsulate to own class
  PLAYERS = {
    "Player 1" => { chip: :black, color: :white },
    "Player 2" => { chip: :red, color: :red }
  }

  def initialize
    @board = Board.new
    @current_player , _ = PLAYERS.first
    @board.print_grid
    @user_input_column = nil
  end

  def start
    puts 'A new game has begun!'

    play_turn until @board.game_ended?
  end

  def play_turn
    puts "It's " << @current_player.bold.public_send(PLAYERS[@current_player][:color]) << " turn"
    while !valid_move?
      ask_for_row until valid_column?
      drop_checker
    end

    end_turn
  end

  def ask_for_row
    puts "Enter row where to play chip:"
    user_row = gets.chop

    @user_input_column = user_row.to_i if user_row.size == 1
    puts "Invalid input, please enter a column between #{@board.headers}" if !valid_column?
  end

  def drop_checker
    @valid_move = @board.make_move(PLAYERS[@current_player], @user_input_column)
    reset_user_column unless valid_move?
  end

  def end_turn
    switch_player
    reset_user_column
    reset_move_validity
    @board.print_grid
  end

  private

  def valid_move?
    !@valid_move.nil? && !!@valid_move
  end

  def valid_column?
    !@user_input_column.nil? && @user_input_column.is_a?(Integer) && @board.headers.include?(@user_input_column)
  end

  # There can only be two players, so this is fine :)
  def switch_player
    next_player = PLAYERS.keys - [@current_player]
    @current_player = next_player.first
  end

  def reset_user_column
    @user_input_column = nil
  end

  def reset_move_validity
    @valid_move = nil
  end
end
