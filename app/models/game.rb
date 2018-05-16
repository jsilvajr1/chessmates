class Game < ApplicationRecord
  
  has_many :pieces

  belongs_to :white_player, class_name: 'User'
  belongs_to :black_player, class_name: 'User', required: false

  validates :game_name, presence: true, length: { maximum: 140, minimum: 3 }
end
