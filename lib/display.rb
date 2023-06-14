require_relative "text_formatting.rb"

module Display 
    include TextFormatting

    def prompt_game_mode
        puts <<~HEREDOC

        Would you like to be the code MAKER or code BREAKER?
        
        Press '1' to be the code MAKER
        Press '2' to be the code BREAKER
        
        HEREDOC
    end

    def show_game_mode_input_error
        puts "\e[31mPlease, enter a valid choice: 1 or 2.\e[0m"
    end

    def code_breaker_intro
        puts <<~HEREDOC
            Okay, let's go Code Breaker!

            A random code has been generated, and now you have to guess it.
        HEREDOC
    end

    def code_maker_intro
        puts <<~HEREDOC
            Okay, let's go Code Maker!

            Choose your code now!
        HEREDOC
    end

    def prompt_guess(turns)
        puts "Make a guess! You have #{turns} turns left."
    end

    def show_computer_turn(turn)
        puts "Computer guess: #{turn}"
    end

    def show_guess_input_error
        puts "\e[31mPlease, enter a 4 digit number, e.g. 1545 or 1 5 4 5.\e[0m"
    end

    def show_guess_results(guess, clues)
        puts <<~HEREDOC
            #{guess.join}    clues: #{clues.join}
        HEREDOC
    end

    def show_player_win(move)
        extension = "th"
        extension = "st" if move == 1
        extension = "nd" if move == 2
        extension = "rd" if move == 3
        puts "Correct guess! You guessed it on the #{move}#{extension} move." 
    end

    def show_player_out_of_turns(code)
        puts <<~HEREDOC
            "Game over! You are out of turns."
            The correct code was #{code.join}
        HEREDOC
        end

    def show_computer_win(turn)
        extension = "th"
        extension = "st" if turn == 1
        extension = "nd" if turn == 2
        extension = "rd" if turn == 3
        puts "Game over! The computer broke your code on the #{turn}#{extension} guess." 
    end

    def show_computer_out_of_turns
        puts "You win! Computer is out of turns."
    end

    def prompt_play_again
        puts "Do you want to play again? (y / n)"
    end

    def instructions
        puts <<~HEREDOC

            #{formatting('underline', 'How to play Mastermind:')}
        
            This is a 1-player game against the computer.
            You can choose to be the code #{formatting('underline', 'maker')} or the code #{formatting('underline', 'breaker')}.
        
            There are six different number/color combinations:
        
            #{code_colors('1')}#{code_colors('2')}#{code_colors('3')}#{code_colors('4')}#{code_colors('5')}#{code_colors('6')}
        
        
            The code maker will choose four to create a 'master code'. For example,
        
            #{code_colors('1')}#{code_colors('3')}#{code_colors('4')}#{code_colors('1')}
        
            As you can see, there can be #{formatting('red', 'more then one')} of the same number/color.
            In order to win, the code breaker needs to guess the 'master code' in 12 or less turns.
        
        
            #{formatting('underline', 'Clues:')}
            After each guess, there will be up to four clues to help crack the code.
        
            #{clue_colors('*')}This clue means you have 1 correct number in the correct location.
        
            #{clue_colors('?')}This clue means you have 1 correct number, but in the wrong location.
        
        
            #{formatting('underline', 'Clue Example:')}
            To continue the example, using the above 'master code' a guess of "1463" would produce 3 clues:
        
            #{code_colors('1')}#{code_colors('4')}#{code_colors('6')}#{code_colors('3')}  Clues: #{clue_colors('*')}#{clue_colors('?')}#{clue_colors('?')}
        
        
            The guess had 1 correct number in the correct location and 2 correct numbers in a wrong location.
        
            #{formatting('underline', "It's time to play!")}

        HEREDOC
    end
end