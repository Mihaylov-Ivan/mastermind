require 'pry-byebug'

require './display.rb'


class Game
    include Display

    def initialize
        @game_mode = nil
        instructions
    end
    
    def play
        prompt_game_mode
        get_game_mode
        @game_mode == "1" ? (CodeMaker.new).play : (CodeBreaker.new).play
        prompt_play_again
        play_again = gets.chomp.downcase
        play_again == "y" ? play : puts("Thanks for playing!")
    end

    protected

    def get_code_input
        code = gets.chomp.gsub(/\s+/, "").split("")
        until code.all? {|item| item.match?(/[1-6]$/)} && code.length == 4
            show_guess_input_error
            code = gets.chomp.gsub(/\s+/, "").split("")
        end
        code
    end

    def create_clues(code, guess)
        temp_code = code.clone
        temp_guess= guess.clone
        exact = exact_number(temp_code, temp_guess)
        same = same_number(temp_code, temp_guess)
        clues = exact + same
    end

    def exact_number(temp_code, temp_guess)
        clues = []
        temp_guess.each_with_index do |guess_digit, guess_index|
            if guess_digit == temp_code[guess_index] then
                temp_code[guess_index] = "x"
                temp_guess[guess_index] = "x"
                clues.append("*")
            end
        end
        clues
    end

    def same_number(temp_code, temp_guess)
        clues = []
        temp_guess.each_with_index do |guess_digit, guess_index|
            next unless temp_guess[guess_index] != 'x' && temp_code.include?(guess_digit)
            temp_guess[guess_index] = "x"
            i = temp_code.index(guess_digit)
            temp_code[i] = "x"
            clues.append("?")
        end
        clues
    end

    def format_clues(clues)
        formatted_clues = clues.map {|n| clue_colors(n)}
        formatted_clues
    end

    def format_code(guess)
        formatted_guess = guess.map {|n| code_colors(n)}
        formatted_guess
    end

    def check_correct_guess(clues)
        clues.all?("*") && clues.length == 4
    end

    private
    
    def get_game_mode
        @game_mode = gets.chomp
        until @game_mode == "1" || @game_mode == "2"
            show_game_mode_input_error
            get_game_mode
        end
    end
end