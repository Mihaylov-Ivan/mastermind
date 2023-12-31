require './text_formatting'
require './display.rb'

class CodeBreaker < Game
    include TextFormatting
    include Display

    attr_reader :code

    def initialize
        @code = []
        generate_code
        code_breaker_intro
    end

    def play
        turns = 0
        until turns == 12
            prompt_guess(12 - turns)
            current_guess = get_code_input
            current_guess_formatted = format_code(current_guess.clone)
            clues = create_clues(code.clone, current_guess)
            clues_formatted = format_clues(clues.clone)
            puts @code
            show_guess_results(current_guess_formatted, clues_formatted)
            break if check_correct_guess(clues)
            turns += 1
        end
        turns < 13 ? show_player_win(turns) : show_player_out_of_turns(format_code(code))
    end

    private 

    def generate_code
        4.times do 
            num = rand(1..6)
            @code.push(num.to_s)
        end
    end
end