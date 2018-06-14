require 'rails_helper'

RSpec.describe Rook, type: :model do

  it "should allow a rook to move vertically on board" do
    game = FactoryBot.create(:game)
    rook = Rook.create(location_x: 4, location_y: 3, game_id: game.id)
    expect(rook.valid_move?(4,5)).to be true
  end

  it "should allow a rook to move horizontally on board" do
    game = FactoryBot.create(:game)
    rook = Rook.create(location_x: 3, location_y: 3, game_id: game.id)
    expect(rook.valid_move?(6,3)).to be true

  end

  it "shouldn't allow moves outside the chessboard" do
    game = FactoryBot.create(:game)
    rook = Rook.create(location_x: 5, location_y: 5, game_id: game.id)
    expect(rook.valid_move?(8,8)).to be false
  end

  it "shouldn't allow rook to move past an obstruction" do
    game = FactoryBot.create(:game)
    rook = Rook.create(location_x: 0, location_y: 3, game_id: game.id)
    pawn = Pawn.create(location_x: 0, location_y: 5, game_id: game.id)
    expect(rook.valid_move?(0,7)).to be false
  end

  it "shouldn't allow a rook to move non-linear (diagonal) on the board" do
    game = FactoryBot.create(:game)
    rook = Rook.create(location_x: 0, location_y: 3, game_id: game.id)
    expect(rook.valid_move?(3,4)).to be false
    expect(rook.valid_move?(4,5)).to be false
    expect(rook.valid_move?(5,6)).to be false
  end
end
