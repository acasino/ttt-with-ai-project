class Game

    attr_accessor :board, :player_1, :player_2


    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]

    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new) #requires you to default values
        @player_1 = player_1
        @player_2 = player_2
        @board = board
    end

    def current_player
        @board.turn_count.odd? ? @player_2 : @player_1
    end

    def won?
        WIN_COMBINATIONS.detect do |win_combo|
            @board.cells[win_combo[0]] == @board.cells[win_combo[1]] && @board.cells[win_combo[1]] == @board.cells[win_combo[2]] && @board.taken?(win_combo[0]+1)
        end
    end

    def draw?
        !won? && @board.full?
    end

    def over?
        draw? || won?
    end

    def winner
        if winning_combo = won?
            @winner = @board.cells[winning_combo.first]
        end
    end

    def turn
        #current player
        player = current_player
        #current move 
        current_move = player.move(@board)
        #check for validity
        if !@board.valid_move?(current_move)
          #if current move isn't valid, repeat turn
          turn
        #else if valid move display board
        else         #if valid move, use update method and display board
            puts "Turn #: #{@board.turn_count + 1}"
            @board.display
            @board.update(current_move, player)
            puts "#{player.token} moved #{current_move}"
            @board.display
            puts ""
        end
    end

    def play
        while !over?
            turn        
        end
        puts won? ? "Congratulations #{winner}!" :  "Cat's Game!" 
        # if won?
        #     puts "Contratulations #{winner}!"
        # elsif draw?
        #     puts "Cat's Game!"
        # end
    end




end
