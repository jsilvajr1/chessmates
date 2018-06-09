require 'rails_helper'

RSpec.describe Pawn, type: :model do
  it "should allow white pawns to move horizontally 1 place at a time" do
    game = FactoryBot.create(:game)
    piece1 = Pawn.create(location_x: 1, location_y: 2, game_id: game.id, white:true)
    piece1.save!
    piece1.valid_move?(1,3)
    expect(piece1.valid_move?(1,3)).to be true
  end

  it "should allow black pawns to move horizontally 1 place at a time" do
    game = FactoryBot.create(:game)
    piece1 = Pawn.create(location_x: 0, location_y: 5, game_id: game.id, white:false)
    piece1.save!
    piece1.valid_move?(0,4)
    expect(piece1.valid_move?(0,4)).to be true
  end

  it "shouldn't allow white pawns to move horizontally more than 1 place at a time" do
    game = FactoryBot.create(:game)
    piece1 = Pawn.create(location_x: 1, location_y: 1, game_id: game.id, white:true)
    piece1.save!
    piece1.valid_move?(2,2)
    expect(piece1.valid_move?(2,2)).to be false
  end

  it "shouldn't allow black pawns to move horizontally more than 1 place at a time" do
    game = FactoryBot.create(:game)
    piece1 = Pawn.create(location_x: 0, location_y: 6, game_id: game.id, white:false)
    piece1.save!
    piece1.valid_move?(0,3)
    expect(piece1.valid_move?(0,3)).to be false
  end

  it "should check if it is white pawn inital movement" do
    game = FactoryBot.create(:game)
    piece1 = Pawn.create(location_x: 0, location_y: 1, game_id: game.id, white:true)
    piece1.save!
    piece1.has_moved?
    expect(piece1.has_moved?).to be false
  end

  it "should check if it is black pawn inital movement" do
    game = FactoryBot.create(:game)
    piece1 = Pawn.create(location_x: 0, location_y: 6, game_id: game.id, white:false)
    piece1.save!
    piece1.has_moved?
    expect(piece1.has_moved?).to be false
  end

  it "should check if it is white pawn inital movement" do
    game = FactoryBot.create(:game)
    piece1 = Pawn.create(location_x: 0, location_y: 2, game_id: game.id, white:true)
    piece1.save!
    piece1.has_moved?
    expect(piece1.has_moved?).to be true
  end

  it "should check if it is black pawn inital movement" do
    game = FactoryBot.create(:game)
    piece1 = Pawn.create(location_x: 0, location_y: 5, game_id: game.id, white:false)
    piece1.save!
    piece1.has_moved?
    expect(piece1.has_moved?).to be true
  end

  it "should allow 2 places movement if it's the first move" do
    game = FactoryBot.create(:game)
    piece1 = Pawn.create(location_x: 0, location_y: 6, game_id: game.id, white:false)
    piece1.save!
    piece1.valid_move?(0,4)
    expect(piece1.valid_move?(0,4)).to be true
  end

  it "should capture up one and one horizontal move to capture" do
    game = FactoryBot.create(:game)
    piece1 = Pawn.create(location_x: 0, location_y: 1, game_id: game.id, white:true)
    piece1.save!
    piece2 = Pawn.create(location_x: 1, location_y: 2, game_id: game.id, white:false)
    piece2.save!
    piece1.capture(1,2)
    expect(piece1.capture(1,2)).to be true
  end

  it "should capture up one and one horizontal move to capture" do
    game = FactoryBot.create(:game)
    piece1 = Pawn.create(location_x: 0, location_y: 6, game_id: game.id, white:false)
    piece1.save!
    piece2 = Pawn.create(location_x: 1, location_y: 5, game_id: game.id, white:true)
    piece2.save!
    piece1.capture(1,5)
    expect(piece1.capture(1,5)).to be true
  end



end
