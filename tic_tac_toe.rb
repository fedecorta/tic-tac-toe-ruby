=begin

possible_options = ["A1","A2","A3","B1","B2","B3","C1","C2","C3"]
puts "Welcome to a new game of TIC TAC TOE"

board = [
  [nil, nil, nil],
  [nil, nil, nil],
  [nil, nil, nil],
]

def map_player_input_to_cell(input)
    position_map = {'A' => 0, 'B' => 1, 'C' => 2, '1' => 0, '2' => 1, '3' => 2}
    row = position_map[input[0]]
    column = position_map[input[1]]
    [row, column] 
end

def print_board(board)
  board.each do |row|
    row_display = row.map { |cell| cell.nil? ? " " : cell }.join(" | ")
    puts row_display
    puts "---------"
  end
end

def check_winner(board)
    board.each do |row|
      return row[0] if row.uniq.length == 1 && row[0] != nil
    end

    (0..2).each do |col|
      column = [board[0][col], board[1][col], board[2][col]]
      return column[0] if column.uniq.length == 1 && column[0] != nil
    end

    diagonal1 = [board[0][0], board[1][1], board[2][2]]
    diagonal2 = [board[0][2], board[1][1], board[2][0]]
    return board[1][1] if diagonal1.uniq.length == 1 || diagonal2.uniq.length == 1 && board[1][1] != nil
    nil
  end

round = 0
winner = nil

while possible_options.size > 0
    player = round.even? ? "Player A" : "Player B"
    puts "#{player}, please select your cell: "

    player_input = gets.chomp().upcase 

    if possible_options.include?(player_input)
        assignment = round.even? ? "X" : "O"
        board_position = map_player_input_to_cell(player_input)
        board[board_position[0]][board_position[1]] = assignment
        possible_options.delete(player_input)

        print_board(board) 

        winner = check_winner(board) 
        if winner
            winner_message = winner == "X" ? "Player A wins" : "Player B wins"
            puts winner_message
            break  
        end

        round += 1
    else
        puts "Invalid option. Please try again."
    end
end

if winner.nil?
    puts "It is a tie"
end

=end

class Player
    attr_reader :marker
  
    def initialize(marker)
      @marker = marker
    end
  end

  class Board
    attr_accessor :board, :possible_options

    def initialize
      @board = Array.new(3) { Array.new(3) }
      @possible_options = ["A1", "A2", "A3", "B1", "B2", "B3", "C1", "C2", "C3"]
    end

    def print_board
        @board.each do |row|
            row_display = row.map { |cell| cell.nil? ? " " : cell }.join(" | ")
            puts row_display
            puts "---------"
        end
    end

    def map_position_to_indices(position)
        position_map = {"A" => 0, "B" => 1, "C" => 2}
        row = position_map[position[0]]
        column = position[1].to_i - 1
        [row, column]
    end

    def make_move(position, marker)
        if @possible_options.include?(position)
            row, column = map_position_to_indices(position)
            @board[row][column] = marker
            @possible_options.delete(position)
        else
            puts "The position is not available. Choose another"
        end    
    end
  
    def check_winner
        @board.each do |row|
            return row[0] if row.uniq.length == 1 && row[0] != nil
          end
      
          (0..2).each do |col|
            column = [@board[0][col], @board[1][col], @board[2][col]]
            return column[0] if column.uniq.length == 1 && column[0] != nil
          end
      
          diagonal1 = [@board[0][0], @board[1][1], @board[2][2]]
          diagonal2 = [@board[0][2], @board[1][1], @board[2][0]]
          return @board[1][1] if diagonal1.uniq.length == 1 || diagonal2.uniq.length == 1 && @board[1][1] != nil
          nil
    end
  end

class Game
    def initialize
      @board = Board.new
      @player_x = Player.new("X")
      @player_o = Player.new("O")
      @current_player = @player_x
    end

    def play
      until @board.possible_options.empty?
        take_turn
        winner_marker = @board.check_winner
        if winner_marker
            winner = winner_marker == @player_x.marker ? "Player X" : "Player O"
            puts "#{winner} wins!"
            return
        end
        switch_player
      end
      puts "It's a tie!"
    end

    def reset_game
        @board = Board.new
        @current_player = @player_x
    end
  
    private
  
    def take_turn
        puts "Available moves: #{@board.possible_options.join(', ')}"
        puts "#{@current_player.marker} make your move:"
        player_input = gets.chomp().upcase 
        until @board.possible_options.include?(player_input)
            puts "Invalid input. Try again"
            puts "Available moves: #{@board.possible_options.join(', ')}"
            player_input = gets.chomp().upcase 
        end
      @board.make_move(player_input,@current_player.marker)
      @board.print_board
    end
  
    def switch_player
      @current_player = @current_player == @player_x ? @player_o : @player_x
    end
  end

game = Game.new

begin
    game.play
    puts "Do you want to play again? (y/n)"
    user_input = gets.chomp().downcase
    game.reset_game if user_input == "y"
end while user_input == "y"
