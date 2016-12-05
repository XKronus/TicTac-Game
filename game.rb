require_relative 'board.rb'

class Game
  PLAYERS = %w{X O}
  @playing = true
  @row = 3
  def initialize(starting_player)
    @game_board = Board.new(starting_player)
    @game_board.display
  end
  def play
    puts 'Starting tic-tac-toe...'
    puts ''
    while not @game_board.board_full and not @game_board.winner
      @current_player = get_next_turn
      ask_player_for_move(@current_player)
      @game_board.display
      puts ""
      if @game_board.winner
        puts 'Player ' + @current_player + ' wins.'
      elsif @game_board.board_full
        puts 'Tie Game'
      else
        puts ''
      end
    end
    puts 'Game Over'
  end
  def ask_player_for_move (current_player)
    played = false
    until played
      puts 'Player ' + @current_player + ': Where would you like to play?'
      #convert input to integer from string
      move = gets.to_i - 1
      #convert 1-9 to 0-2 by using modulo operation
      col = move % 3
      #convert input to row 0-2
      row = (move - col) / 3
      if @game_board.validate_position(row, col)
        @game_board.fill_position(row, col, @current_player)
        played = true
      end
    end
  end
  def get_next_turn
    if @current_player == 'X'
      @current_player = 'O'
    else
      @current_player = 'X'
    end
    @current_player
  end
  def next_player
    if @current_player == 'X'
      @current_player = 'O'
    end
  end
end
