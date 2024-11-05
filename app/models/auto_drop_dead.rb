require_relative 'player.rb'

class AutoDropDead
    def play_game(sides, dice_count, player_count)
        # Validate sides to avoid infinite loop
        if sides < 2
          puts "Each die must have at least 2 sides for the game to work."
          return
        end

        players = Array.new(player_count) { |i| Player.new("Player #{i + 1}", sides, dice_count) }
        players_copy = players.dup
        round_number = 1
        game_summary = []

        while players_copy.any?
            game_summary << "\n--- Round #{round_number} ---"
            players_copy.each do |player|

                if !player.dice?
                    game_summary << "#{player.name} has no dice left and is out of the game."
                    next
                end

                round_points = 0

                loop do
                    game_summary << "\n#{player.name}'s turn: (#{player.dice.length} dice remaining)"
                    roll_results = player.roll_dice
                    game_summary << "Rolled: #{roll_results.inspect}"

                    if roll_results.include?(2)
                        game_summary << "#{player.name} rolled a 2, removing all 2s..."
                    end

                    if roll_results.include?(5)
                        game_summary << "#{player.name} rolled a 5, removing all 5s..."
                    end

                    player.remove_dice(roll_results)

                    if !player.dice?
                        game_summary << "#{player.name} has no dice left and is out of the game."
                        break
                    else
                        points_scored = roll_results.reject { |n| n == 2 || n == 5 }.sum
                        round_points += points_scored
                        game_summary << "#{player.name} scored #{points_scored} points this roll."

                        break if roll_results.any? { |n| n == 2 || n == 5 }
                    end
                end

                # Add round points to player's total score
                player.add_score(round_points)
                game_summary << "#{player.name} has #{player.score} total points."

            end

            # Remove players who have no dice left
            players_copy.select! { |player| player.dice? }
            round_number += 1
        end

        winner = players.max_by { |player| player.score }
        game_summary << "\nGame has ended. #{winner.name} wins with #{winner.score} points!"
    end
end