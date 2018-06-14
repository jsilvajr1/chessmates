class Game < ApplicationRecord

  has_many :pieces, :dependent => :delete_all

  belongs_to :white_player, class_name: 'User'
  belongs_to :black_player, class_name: 'User', optional: true # was "required: false" but that seemed too strict
  after_create :populate_game! # this runs the populate_game! method on a newly-created game

  validates :game_name, presence: true, length: { maximum: 140, minimum: 3 }

  scope :available, -> { where black_player_id: nil }

  def self.available
    where(black_player_id: nil)
  end

  def black_player_joined?
    black_player_id == self.black_player_id
  end

  def occupied?(dest_x,dest_y)
    pieces.active.where(location_x: dest_x, location_y: dest_y).any?
  end

  def check?(is_white)
    king = King.where(white: is_white)
    opponents = pieces.active.where(white: !is_white)
    opponents.each do |piece|
      if piece.valid_move?(king.location_x, king.location_y)
        @threatening_piece = piece
        return true
      end
    end
    false
  end

  #def checkmate?(white)
  #  return false unless check?(white)
  #end

  def populate_game!
    piece_type = [Rook, Knight, Bishop, King, Queen, Bishop, Knight, Rook]
    (0..7).each do |i|
      piece_type[i].create(location_x: i, location_y: 0, game_id: self.id, white: true, notcaptured: true)
      Pawn.create(location_x: i, location_y: 1, game_id: self.id, white: true, notcaptured: true)
      piece_type[i].create(location_x: i, location_y: 7, game_id: self.id, white: false, notcaptured: true)
      Pawn.create(location_x: i, location_y: 6, game_id: self.id, white: false, notcaptured: true)
    end
  end
end
