require 'rails_helper'

RSpec.describe Queen, type: :model do
  it "can move along a horizontal path" do
    game = FactoryBot.create(:game)
    queen = Queen.create(game_id: game.id, location_x: 4, location_y: 3)
    move = queen.valid_move?(1,3)

    expect(move).to be true
  end

  it "can move along a vertical path" do
    game = FactoryBot.create(:game)
    queen = Queen.create(game_id: game.id, location_x: 4, location_y: 3)
    move = queen.valid_move?(4,5)

    expect(move).to be true
  end

  it "can move along a true diagonal path" do
    game = FactoryBot.create(:game)
    queen = Queen.create(game_id: game.id, location_x: 4, location_y: 3)
    move = queen.valid_move?(6,5)

    expect(move).to be true
  end

  it "cannot move along a non-true diagonal path" do
    game = FactoryBot.create(:game)
    queen = Queen.create(game_id: game.id, location_x: 4, location_y: 3)
    move = queen.valid_move?(7,4)

    expect(move).to be false
  end

  it "cannot move outside the board" do
    game = FactoryBot.create(:game)
    queen = Queen.create(game_id: game.id, location_x: 4, location_y: 3)
    move = queen.valid_move?(8,3)

    expect(move).to be false
  end

  it "cannot move past an obstruction" do
    game = FactoryBot.create(:game)
    queen = Queen.create(game_id: game.id, location_x: 4, location_y: 3)
    pawn = Pawn.create(game_id: game.id, location_x: 3, location_y: 4)
    move = queen.valid_move?(2,5)
    
    expect(move).to be false
  end
end
