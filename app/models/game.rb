class Game < ApplicationRecord

  has_many :pieces

  belongs_to :white_player, :class_name => 'User'
  belongs_to :black_player, :class_name => 'User'

  validates :name, presence: true, length: { maximum: 140, minimum: 3 }


  def black_player_joined?
    black_player_id == current_user
  end
end
