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
        @correct_guess = false
        generate_code
        code_breaker_intro
    end

    def play
        turns = 0
        until @correct_guess || turns == 12
            prompt_guess(12 - turns)
            @current_guess = get_code_input
            @current_guess_formatted = format_guess(@current_guess.clone)
            @clues = create_clues(@code.clone, @current_guess)
            @clues_formatted = format_clues(@clues.clone)
            puts @code
            show_guess_results(@current_guess_formatted, @clues_formatted)
            check_correct_guess(@clues)
            turns+=1
        end
        @correct_guess ? show_correct_guess(turns) : show_out_of_turns
    end

    private 

    def generate_code
        6.times do 
            num = rand(1..6)
            @code.push(num.to_s)
        end
        @code = ["1", "3", "5", "3", "2", "5"]
    end
end