class Dice
    def initialize(sides)
        @sides = sides
    end
    
    # returns random number from 1 to number of sides on the dice
    def roll
        return rand(1..@sides)
    end
end