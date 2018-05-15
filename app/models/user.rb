class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :initiated_games, :class_name => 'Game', foreign_key: 'white_player_id'
  has_many :joined_games, :class_name => 'Game', foreign_key: 'black_player_id'

end
