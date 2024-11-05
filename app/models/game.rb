class Game < ApplicationRecord
  belongs_to :user

  validates :number_of_players, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :number_of_sides, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :number_of_dice, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :started_at, presence: true

  private 
end