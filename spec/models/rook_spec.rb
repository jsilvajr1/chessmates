require 'rails_helper'

RSpec.describe Rook, type: :model do

  it "should allow a rook to move vertically on board" do
    game = FactoryBot.create(:game)
    piece1 = Rook.create(location_x: 1, location_y: 1, game_id: game.id)
    expect(piece1.valid_move?(1,6)).to be true
  end

  it "should allow a rook to move horizontally on board" do
    game = FactoryBot.create(:game)
    piece1 = Rook.create(location_x: 3, location_y: 3, game_id: game.id)
    expect(piece1.valid_move?(6,3)).to be true

  end

  it "shouldn't allow moves outside the chessboard" do
    game = FactoryBot.create(:game)
    piece1 = Rook.create(location_x: 0, location_y: 0, game_id: game.id)
    expect(piece1.valid_move?(8,8)).to be false

  end

end

=begin 
  questions to review w/ roye
  added tests for moving Hor & Ver. Check obstructed method specs - do they cover the following situations:
    - if cur_loc is (1,3), dest is (6,3) but there's a team piece at (3,3). does obstructed method create an invalid path error
      because can't jump pieces
    - if cur_loc is (1,3), dest is (6,3) but there's an enemy at (3,3). does captured method know to capture the enemy piece
      and update rook dest to (3,3) vs (6,3)? rook can't move forward, ie. can't capture then continue w initial dest plan
    - if theres a team piece at destination. does obstructed method cite an error message "invalid path"?

    - in the piece_spec.rb - why do we create pieces w/ some tests and find the pieces with others?
    - move_to method in piece model accounts for destinations.
    - recieving failure errow in test w/ line 27
=end