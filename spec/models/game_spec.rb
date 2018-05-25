require 'rails_helper'

RSpec.describe Game, type: :model do
  it "will not be valid with an empty name" do
    game = FactoryBot.build(:game, game_name: "")

    expect(game).not_to be_valid
  end

  it "will not be valid with a name less than 3 characters" do
    game = FactoryBot.build(:game, game_name: "Bo")

    expect(game).not_to be_valid
  end

  it "will generate all chess pieces when created" do
    game = FactoryBot.create(:game)
    game.populate_game!

    isWhiteRook = game.pieces.find_by(location_x: 0, location_y: 0)
    isBlackPawn = game.pieces.find_by(location_x: 4, location_y: 6)
    isWhitePawn = game.pieces.find_by(location_x: 0, location_y: 1)
    isBlackBishop = game.pieces.find_by(location_x: 2, location_y: 7)
    isBlackRook = game.pieces.find_by(location_x: 0, location_y: 7)
    isWhiteKing = game.pieces.find_by(location_x: 3, location_y: 0)
    isBlackQueen = game.pieces.find_by(location_x: 4, location_y: 7)

    expect(game.pieces.count).to eq(32)
    expect(game.pieces.where(white: true).count).to eq(16)
    expect(game.pieces.where(white: false).count).to eq(16)

    expect(isWhiteRook.type).to eq("Rook")
    expect(isWhiteRook.white).to be true

    expect(isBlackPawn.type).to eq("Pawn")
    expect(isBlackPawn.white).to be false

    expect(isWhitePawn.type).to eq("Pawn")
    expect(isWhitePawn.white).to be true

    expect(isBlackBishop.type).to eq("Bishop")
    expect(isBlackBishop.white).to be false

    expect(isBlackRook.type).to eq("Rook")
    expect(isBlackRook.white).to be false

    expect(isWhiteKing.type).to eq("King")
    expect(isWhiteKing.white).to be true

    expect(isBlackQueen.type).to eq("Queen")
    expect(isBlackQueen.white).to be false
  end
end
