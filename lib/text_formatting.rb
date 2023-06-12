module TextFormatting

    def code_colors(number)
        {
            '1' => "\e[101m  1  \e[0m ",
            '2' => "\e[43m  2  \e[0m ",
            '3' => "\e[44m  3  \e[0m ",
            '4' => "\e[45m  4  \e[0m ",
            '5' => "\e[46m  5  \e[0m ",
            '6' => "\e[41m  6  \e[0m ",
        }[number]
    end

    def formatting(formatting, string)
        {
            'underline' => "\e[4;1m#{string}\e[0m",
            'red' => "\e[31;1m#{string}\e[0m"
        }[formatting]
    end

    def clue_colors(clue)
        {
          '*' => "\e[91m\u25CF\e[0m ",
          '?' => "\e[37m\u25CB\e[0m "
        }[clue]
      end
end