require_relative "dice.rb"

class Player
    attr_reader :name, :dice, :score

    def initialize(name, sides, dice_count)
      @name = name
      @score = 0
      @dice = Array.new(dice_count) { Dice.new(sides) }
    end

    # Rolls all the remaining dice the player has left
    def roll_dice
      @dice.map(&:roll)
    end

    # Adds points to the players score
    def add_score(points)
      return @score += points
    end

    # Chekcs if the player has any dice left
    def dice?
      return !@dice.empty?
    end

    # Removes and dice that rolled a 2 or 5
    def remove_dice(roll_results)
      @dice = @dice.zip(roll_results).reject { |_, roll| roll == 2 || roll == 5 }.map(&:first)
    end
end