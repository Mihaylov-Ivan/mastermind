require './text_formatting'
require './display.rb'

class CodeBreaker < Game
    include TextFormatting
    include Display

    attr_reader :current_guess_formatted, :clues_formatted, :clues
    attr_reader :code

    def initialize
        @code = []
        @current_guess = []
        @current_guess_formatted = []
        @clues = []
        @clues_formatted = []
        generate_code
        code_breaker_intro
    end

    def play
        moves = 0
        until @correct_guess || moves == 12
            prompt_guess(12 - moves)
            get_guess
            get_clues
            puts @code
            show_guess_results(@current_guess_formatted, @clues_formatted)
            check_correct_guess(@clues)
            moves+=1
        end
        @correct_guess ? show_correct_guess(moves) : show_out_of_moves
    end

    private 

    def get_guess
        @current_guess = get_code_input
        @current_guess_formatted = @current_guess.map {|n| code_colors(n)}
    end

    def get_clues
        @clues = create_clues(@code.clone, @current_guess)
        @clues_formatted = @clues.map {|n| clue_colors(n)}
    end

    def generate_code
        6.times do 
            num = rand(1..6)
            @code.push(num.to_s)
        end
        @code = ["1", "3", "5", "3", "2", "5"]
    end
end