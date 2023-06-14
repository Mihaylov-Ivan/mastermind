require 'pry-byebug'

require './text_formatting'
require './display.rb'

class CodeMaker < Game
    include TextFormatting
    include Display

    attr_accessor :guess_record, :turn, :exact, :same
    attr_reader :code

    def initialize
        code_maker_intro
        @code = get_code_input
        @exact = nil
        @same = nil
        @turn = 1
    end

    def play
        numbers = ["1", "2", "3", "4", "5", "6"].shuffle!
        @guess_record = []
        four_numbers = find_four_numbers(numbers)
        return game_over if turn > 12
        guess_perm = four_numbers.permutation.to_a.uniq
        reduce_permutations(guess_perm)
        until turn > 12
            sleep(1)
            show_computer_turn(turn)
            clues = make_a_turn(guess_perm[0])
            correct_guess = clues.all?("*")
            break if correct_guess
            reduce_permutations(guess_perm)
            @turn += 1
        end
        game_over
    end

    def find_four_numbers(numbers, guess = [], index = 0)
        sleep(1)
        show_computer_turn(turn)
        guess.append(numbers[index]) until guess.length == 4
        clues = make_a_turn(guess)
        guess.pop(4-exact-same)
        return if turn > 12
        @turn += 1
        find_four_numbers(numbers, guess, index + 1) unless clues.length == 4
        guess
    end

    def make_a_turn(guess)
        clues = create_clues(code.clone, guess.clone)
        @exact = clues.count("*")
        @same = clues.count("?")
        guess_record.append([guess.clone, exact, same])
        show_guess_results(format_guess(guess), format_clues(clues))
        clues
    end

    def reduce_permutations(guess_perm)
        guess_record.each do |guess|
            guess_perm.each do |perm|
                clues = create_clues(guess[0].clone, perm.clone)
                guess_perm.reject! {|reject| reject == perm} unless guess[1] == clues.count('*') && guess[2] == clues.count('?')
            end
        end
    end

    def game_over
        turn < 13 ? show_computer_correct_guess(turn) : show_computer_out_of_turns
    end
end