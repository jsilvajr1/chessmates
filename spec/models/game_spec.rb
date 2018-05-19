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

  it "will add user2 as black_player" do
    game = FactoryBot.create(:game)
    user2 = FactoryBot.create(:user)
    sign_in user2
    patch :update, params: {black_player_id: user2.id}
    expect(response).to redirect_to game_path(game)
    game.reload
    expect(game.black_player_id).to eq (user2.id)
    expect(game.white_player_id).to eq (game.user.id)
  end
end
