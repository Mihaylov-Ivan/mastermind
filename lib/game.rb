require 'pry-byebug'

require './display.rb'


class Game
    include Display

    def initialize
        @correct_guess = false
        instructions
        prompt_game_mode
        @game_mode = get_game_mode
        # @game_mode == "1" ? play_code_maker : play_code_breaker
        # @game_mode == "1" ? play_code_breaker : play_code_breaker
        @game_mode == "1" ? (CodeBreaker.new).play : (CodeBreaker.new).play
    end

    protected

    def get_code_input
        code = gets.chomp.gsub(/\s+/, "").split("")
        until code.all? {|item| item.match?(/[1-6]$/)} && code.length == 6
            show_guess_input_error
            code = gets.chomp.gsub(/\s+/, "").split("")
        end
        code
    end

    def create_clues(code, guess)
        match = []
        clues = []
        code_index = nil
        guess.each_with_index do |guess_digit, guess_index|
            if guess_digit == code[guess_index]
                clues.insert(0, "*")
                puts code.inspect
                code[guess_index] = "x"
                guess[guess_index] = "x"
            else
                match = code.select {|code_digit| code_digit == guess_digit}
                if match.uniq.length == 1 then
                    i = code.index(guess_digit)
                    code[i] = "x"
                    guess[guess_index] = "x"
                    clues.append("?")
                end
            end
        end
        clues
    end

    def check_correct_guess(clues)
        @correct_guess = clues.all?{|clue| clue == "*"} && clues.length == 6
    end

    private
    
    def get_game_mode
        @game_mode = gets.chomp
        until @game_mode == "1" || @game_mode == "2"
            show_game_mode_input_error
            get_game_mode
        end
    end

    def play_code_breaker
        player = (CodeBreaker.new).play
        player.play
        # code_breaker_intro
        # until @correct_guess || moves == 12
        #     prompt_guess(12 - moves)
        #     player.get_guess
        #     player.get_clues
        #     puts player.code
        #     show_guess_results(player.current_guess_formatted, player.clues_formatted)
        #     check_correct_guess(player.clues)
        #     moves+=1
        # end
        # @correct_guess ? show_correct_guess(moves) : show_out_of_moves
    end
end