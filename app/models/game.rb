class Game < ApplicationRecord

  has_many :pieces

  belongs_to :white_player, :class_name => 'User', foreign_key: 'user_id'
  belongs_to :black_player, :class_name => 'User', foreign_key: 'user_id'
end
