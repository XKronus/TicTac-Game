class Board

  BOARD_MAX_INDEX = 2
  EMPTY_POS = ' '

=begin
This method will initialize the game and create a new board full of empty positions
current_player = initialized as parameter
board = create a two dimmensional aray (3 x 3)
=end

  def initialize(starting_player)
    @current_player = starting_player
    @board = Array.new(BOARD_MAX_INDEX + 1) {
      Array.new(BOARD_MAX_INDEX + 1) { EMPTY_POS }
    }
  end

=begin
Display method will draw the board and place the current integer of the for loop in place of an empty spot
s = current spot within board given from for loop
For loop goes -
row 1, col 1,2,3
row 2, col 1,2,3
row 3, col 1,2,3

if s = blank, insert col + (row * 3) + 1
=end

  def display
    puts ' +- - - - - -+'
    (0.. BOARD_MAX_INDEX).each { |row|
      print ' | '
      (0.. BOARD_MAX_INDEX).each { |col|
        s = @board[row][col]
        if s == EMPTY_POS
          print col + (row * 3) + 1
        else
          print s
        end
        print ' | '
      }
      puts " \n +- - - - - -+"
    }
  end

=begin
board_full method returns true or false if there are no empty positions in the board
=end

  def board_full
    (0.. BOARD_MAX_INDEX).each { |row|
      (0.. BOARD_MAX_INDEX).each { |col|
        if @board[row][col] == EMPTY_POS
          return false
        end
      }
    }
    return true
  end

=begin
winner method returns true or false if the win conditions are true, or false
=end

  def winner
    winner = winner_rows()
    if winner
      return winner
    end
    winner = winner_cols()
    if winner
      return winner
    end
    winner = winner_diagonals()
    if winner
      return winner
    end
  end

=begin
winner_rows checks if a row is full of the same symbols - otherwise it breaks and moves to the next row
=end
  def winner_rows
    (0.. BOARD_MAX_INDEX).each { |row_index|
      first_symbol = @board[row_index][0]
      (1.. BOARD_MAX_INDEX).each { |col_index|
        if first_symbol != @board[row_index][col_index]
          break
        elsif col_index == BOARD_MAX_INDEX and first_symbol != EMPTY_POS
          return first_symbol
        end
      }
    }
    return
  end

=begin
winner_cols checks if the columns are the same - otherwise it breaks and moves to next column
=end

  def winner_cols
    (0.. BOARD_MAX_INDEX).each { |col_index|
      first_symbol = @board[0][col_index]
      (1.. BOARD_MAX_INDEX).each { |row_index|
        if first_symbol != @board[row_index][col_index]
          break
        elsif row_index == BOARD_MAX_INDEX and first_symbol != EMPTY_POS
          return first_symbol
        end
      }
    }
    return
  end

=begin
winner_diagnols checks if the two diagnols are the same
Begin by checking the top left corner [0][0].
Then compare with index [1][1] (middle) - if different, break
Finally compare with index [2][2] (bottom right corner) - if different, break
=end

  def winner_diagonals
    first_symbol = @board[0][0]
    (1.. BOARD_MAX_INDEX).each { |index|
      if first_symbol != @board[index][index]
        break
      elsif index == BOARD_MAX_INDEX and first_symbol != EMPTY_POS
        return first_symbol
      end
    }

    #Now check the diagnol the other way board[0][2] is top right corner
    first_symbol = @board[0][BOARD_MAX_INDEX]
    row_index = 0
    col_index = BOARD_MAX_INDEX
    while row_index < BOARD_MAX_INDEX
      row_index = row_index + 1
      col_index = col_index - 1
      if first_symbol != @board[row_index][col_index]
        break
      elsif row_index == BOARD_MAX_INDEX and first_symbol != EMPTY_POS
        return first_symbol
      end
    end
    return
  end

=begin
validate_position method will return true if board[row][col] is empty and not played
=end

  def validate_position(row, col)
    if row <= @board.size and col <= @board.size
      if @board[row][col] == EMPTY_POS
        return true
      else
        puts 'Postition occupied!'
      end
    else
      puts 'Invalid position!'
    end
    return false
  end

=begin
fill_poisition method will fill board[row][col] with the players symbol
=end

  def fill_position(row, col, player)
    @board[row][col] = player
  end
end
