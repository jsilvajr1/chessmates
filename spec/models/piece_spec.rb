require 'rails_helper'

RSpec.describe Piece, type: :model do
  it "determines obstruction in a piece's vertical path going up" do
    game = FactoryBot.create(:game)
    piece1 = Piece.create(location_x: 5, location_y: 1, game_id: game.id)
    piece1.save!
    piece2 = Piece.create(location_x: 5, location_y: 3, game_id: game.id)
    piece2.save!

    expect(piece1.is_obstructed?(5,5)).to be true
  end

  it "determines obstruction in a piece's vertical path going down" do
    game = FactoryBot.create(:game)
    piece1 = Piece.create(location_x: 2, location_y: 7, game_id: game.id)
    piece1.save!
    piece2 = Piece.create(location_x: 2, location_y: 4, game_id: game.id)
    piece2.save!

    expect(piece1.is_obstructed?(2,0)).to be true
  end

  it "determines obstruction in a piece's horizontal path going left" do
    game = FactoryBot.create(:game)
    piece1 = Piece.create(location_x: 0, location_y: 5, game_id: game.id)
    piece1.save!
    piece2 = Piece.create(location_x: 2, location_y: 5, game_id: game.id)
    piece2.save!

    expect(piece1.is_obstructed?(3,5)).to be true
  end

  it "determines obstruction in a piece's horizontal path going right" do
    game = FactoryBot.create(:game)
    piece1 = Piece.create(location_x: 5, location_y: 6, game_id: game.id)
    piece1.save!
    piece2 = Piece.create(location_x: 4, location_y: 6, game_id: game.id)
    piece2.save!

    expect(piece1.is_obstructed?(2,6)).to be true
  end

  it "determines obstruction in a piece's diagonal path going top-right" do
    game = FactoryBot.create(:game)
    piece1 = Piece.create(location_x: 0, location_y: 1, game_id: game.id)
    piece1.save!
    piece2 = Piece.create(location_x: 2, location_y: 3, game_id: game.id)
    piece2.save!

    expect(piece1.is_obstructed?(3,4)).to be true
  end

  it "determines obstruction in a piece's diagonal path going bottom-right" do
    game = FactoryBot.create(:game)
    piece1 = Piece.create(location_x: 1, location_y: 7, game_id: game.id)
    piece1.save!
    piece2 = Piece.create(location_x: 2, location_y: 6, game_id: game.id)
    piece2.save!

    expect(piece1.is_obstructed?(3,5)).to be true
  end

  it "determines obstruction in a piece's diagonal path going top-left" do
    game = FactoryBot.create(:game)
    piece1 = Piece.create(location_x: 6, location_y: 0, game_id: game.id)
    piece1.save!
    piece2 = Piece.create(location_x: 4, location_y: 2, game_id: game.id)
    piece2.save!

    expect(piece1.is_obstructed?(3,3)).to be true
  end

  it "determines obstruction in a piece's diagonal path going bottom-left" do
    game = FactoryBot.create(:game)
    piece1 = Piece.create(location_x: 7, location_y: 6, game_id: game.id)
    piece1.save!
    piece2 = Piece.create(location_x: 6, location_y: 5, game_id: game.id)
    piece2.save!

    expect(piece1.is_obstructed?(4,3)).to be true
  end

  it "determines that a piece's path is invalid for this method" do
    game = FactoryBot.create(:game)
    piece1 = Piece.create(location_x: 1, location_y: 3, game_id: game.id)
    piece1.save!
    piece2 = Piece.create(location_x: 2, location_y: 4, game_id: game.id)
    piece2.save!

    expect(piece1.is_obstructed?(3,6)).to eq("ERROR: Invalid Piece Path")
  end
end