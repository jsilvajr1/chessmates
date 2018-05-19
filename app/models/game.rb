class Game < ApplicationRecord
  
  has_many :pieces

  belongs_to :white_player, class_name: 'User'
  belongs_to :black_player, class_name: 'User', optional: true # was "required: false" but that seemed too strict

  validates :game_name, presence: true, length: { maximum: 140, minimum: 3 }

  scope :available, -> { where black_player_id: nil }

  def self.available
    where(black_player_id: nil)
  end
end
