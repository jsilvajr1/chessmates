require 'rails_helper'

RSpec.describe King, type: :model do
  it "shouldn't allow a movement other than 1 place at a time" do
    game = FactoryBot.create(:game)
    piece1 = King.create(location_x: 2, location_y: 7, game_id: game.id)
    piece1.save!
    piece1.valid_move?(2,5)
    expect(piece1.valid_move?(2,5)).to be false
  end

  it "should allow a movement of 1 place at a time" do
    game = FactoryBot.create(:game)
    piece1 = King.create(location_x: 2, location_y: 7, game_id: game.id)
    piece1.save!
    piece1.valid_move?(2,6)
    expect(piece1.valid_move?(2,6)).to be true
  end
end
