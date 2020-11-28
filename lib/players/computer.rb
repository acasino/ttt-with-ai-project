module Players

    class Computer < Player
        def move(board) #accepts a board and returns the move the computer wants to make in the form of a 1-9 string
            move = nil
            #if going first, take middle. If second, try to take middle if not taken
            if !board.taken?(5)
                move = "5"
            #if going second and middle taken, take upper left 
            elsif board.turn_count == 1
                move "1"
            #if went first and took middle, take a corner that's empty using detect
            elsif board.turn_count == 2
                move = [1,3,7,9].detect{|i| !board.taken(i)}.to_s
            #if you went second and took middle and player has opposing corner take a side square to block
            elsif board.turn_count == 3 && (board.position(1) == board.position(9) || board.position(3) == board.position(7))
                move "2"
            #run thru WIN array, check if any combos have two squares filled with same token and one last empty
            else
                Game::WIN_COMBINATIONS.detect do |combo|
                 #check if you have any winning combos first
                  if commbo.select{|i| board.position(i+1) == token}.size == 2 && combo.any?{|i| board.position(i+1) == " "}
                    move = cmb.select{|i| !board.taken?(i+1)}.first.to_i.+(1).to_s
                 #if not, block
                  elsif combo.select{|i| board.position(i+1) != " " && board.position(i+1) != token}.size == 2 && combo.any?{|i| board.position(i+1) == " "}
                    move = combo.select{|i| !board.taken?(i+1)}.first.to_i.+(1).to_s
                  end
                end
                 #if no WIN have two squares taken by the same token and a 3rd empty, play first open sq
                 move = [1, 3, 7, 9, 2, 4, 6, 8].detect{|i| !board.taken?(i)}.to_s if move == nil
            end
            move
        end 
    end
end
