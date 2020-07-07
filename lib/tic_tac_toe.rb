class Tic_Tac_Toe
    def initialize(board = [" "," "," "," "," "," "," "," "," "])
      @board = board || Array.new(9, " ")
    end
    def display_board
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
      puts "-----------"
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
      puts "-----------"
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
      return input.to_i-1
    end

    def position_taken?(index=0)
      return (@board[index]=="X")||(@board[index]=="O")
    end

    def valid_move?(index=0)
      if position_taken?(index)
        return false
      elsif (index>8) || (index<0)
        return false
      end
      return true
    end

    def move(index,input)
      if valid_move?(index)
        @board[index]=input
        return true
      else
        return false
      end
    end

    def turn_count
      counter=0
      @board.each do |input|
        if (input=="X")||(input=="O")
          counter+=1
        end
      end
      return counter
    end

    def current_player
      counter=turn_count()
      if counter%2==0
        return "X"
      end
      return "O"
    end

    def turn
      puts "Please enter 1-9:"
      input=gets.strip
      index=input_to_index(input)
      input=current_player()
      test=move(index,input)
      until test
        puts "Please enter 1-9:"
        input=gets.strip
        index=input_to_index(input)
        input=current_player()
        test=move(index,input)
      end
      display_board(board)
    end

    WIN_COMBINATIONS=[[0,1,2],[3,4,5],[6,7,8],[0,4,8],[2,4,6],[0,3,6],[1,4,7],[2,5,8]]

    def won?
      WIN_COMBINATIONS.each do |win_combination|
        if (@board[win_combination[0]]==@board[win_combination[1]])&&(@board[win_combination[1]]==@board[win_combination[2]])&&((@board[win_combination[1]]=="X")||(@board[win_combination[1]]=="O"))
          return win_combination
        end
      end
      return false
    end

    def full?
      return !(@board.include?(" "))
    end

    def draw?
      return (full?()&&!won?())
    end

    def over?
      return (draw?()||won?())
    end

    def winner
      arr=won?()
      if arr!=false
        return @board[arr[0]]
      end
      return nil
    end

    def play()
      while !over?()
        turn()
      end
      if draw?()
        puts"Cat's Game!"
      else
        input=winner()
        puts "Congratulations #{input}!"
      end
    end
end
