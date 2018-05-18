require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe "games#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  # describe "games#new action" do
    
  #   it "should require users to be logged in" do
  #     get :new
  #     expect(response).to redirect_to new_user_session_path
  #   end

  #   it "should successfully show the new game form" do
  #     user = FactoryBot.create(:white_player)
  #     sign_in user

  #     get :new
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "games#create action" do

  #   it "should require users to be logged in" do
  #     post :create, params: { game: {game_name: 'ChessKing'} }
  #     expect(response).to redirect_to new_user_session_path
  #   end
    
  #   it "should create a new game in the database" do
  #     user = FactoryBot.create(:white_player)
  #     sign_in user

  #     post :create, params: { game: { game_name: 'ChessKing' } }
  #     expect(response).to redirect_to root_path

  #     game = Game.last
  #     expect(game.game_name).to eq('ChessKing')
  #     expect(game.white_player).to eq(user)
  #   end

  #   it "should properly deal with validation errors (name too short)" do
  #     user = FactoryBot.create(:white_player)
  #     sign_in user

  #     post :create, params: { game: {game_name: 'Bo'} }
  #     expect(response).to have_http_status(:unprocessable_entity)
  #     expect(Game.count).to eq(0)
  #   end

  #   it "should properly deal with validation errors (name blank)" do
  #     user = FactoryBot.create(:white_player)
  #     sign_in user

  #     post :create, params: { game: { game_name: '' } }
  #     expect(response).to have_http_status(:unprocessable_entity)
  #     expect(Game.count).to eq(0)
  #   end
  # end

  # describe "games#show action" do
  #   it "should successfully show the page if the specified game is found" do
  #     game = FactoryBot.create(:game)
  #     get :show, params: { id: game.id }
  #     expect(response).to have_http_status(:success)
  #   end

  #   it "should return a 404 error if the game is not found" do
  #     get :show, params: { id: 'TACOCAT' }
  #     expect(response).to have_http_status(:not_found)
  #   end
  # end

  # describe "games#destroy action" do
  #   it "shouldn't allow users who didn't create a game to destroy it" do
  #     game = FactoryBot.create(:game)
  #     diff_user = FactoryBot.create(:white_player)
  #     sign_in diff_user
  #     delete :destroy, params: { id: game.id }
  #     expect(response).to have_http_status(:forbidden)
  #   end

  #   it "shouldn't let unauthenticated users destroy a game" do
  #     game = FactoryBot.create(:game)
  #     delete :destroy, params: { id: game.id }
  #     expect(response).to redirect_to new_user_session_path
  #   end

  #   it "should allow user to successfully delete games" do
  #     game = FactoryBot.create(:game)
  #     sign_in game.white_player
  #     delete :destroy, params: { id: game.id }
  #     redirect_to root_path

  #     game = Game.find_by_id(game.id)
  #     expect(game).to eq nil
  #   end

  #   it "should return a 404 error if game with the specified id cannot be found" do
  #     user_not_owner = FactoryBot.create(:white_player) # user necessary, else redirected to sign-in page 
  #     sign_in user_not_owner
  #     delete :destroy, params: { id: 'SPACEDUCK' }
  #     expect(response).to have_http_status(:not_found)
  #   end
  # end
end
