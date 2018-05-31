require 'rails_helper'

RSpec.describe PiecesController, type: :controller do

  describe "show#pieces action" do

    it "shouldn't allow unauthenticated users to view piece's show page" do
      whitepiece = FactoryBot.create(:piece)

      get :show, params: { game_id: whitepiece.game_id, id: whitepiece.id }
      expect(response).to redirect_to new_user_session_path
    end

    it "should allow only game players view piece's show page" do
      whitepiece = FactoryBot.create(:piece)
      user_not_player = FactoryBot.create(:white_player)
      sign_in user_not_player

      get :show, params: { game_id: whitepiece.game_id, id: whitepiece.id }
      expect(response). to have_http_status(:forbidden)
    end

    it "should allow only white player view white piece's show page" do
      whitepiece = FactoryBot.create(:piece)
      bplayer = FactoryBot.create(:white_player)
      sign_in bplayer

      get :show, params: { game_id: whitepiece.game_id, id: whitepiece.id }
      expect(response). to have_http_status(:forbidden)
    end

    it "should allow only black player view black piece's show page" do
      bplayer = FactoryBot.create(:white_player)
      game = FactoryBot.create(:game, black_player_id: bplayer.id)
      blackpiece = Piece.find_by(location_x: 0, location_y: 7)
      sign_in game.white_player

      get :show, params: { game_id: blackpiece.game_id, id: blackpiece.id }
      expect(response). to have_http_status(:forbidden)
    end
  
    it "should display the show page for the piece that was clicked" do
      whitepiece = FactoryBot.create(:piece)
      sign_in whitepiece.game.white_player

      get :show, params: { game_id: whitepiece.game_id, id: whitepiece.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a NotFound(404) error if the piece was not found" do
      whitepiece = FactoryBot.create(:piece)
      sign_in whitepiece.game.white_player

      get :show, params: { game_id: whitepiece.game_id, id: 'BOOBOO' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "update#pieces action" do

    it "shouldn't allow unauthenticated users to update piece's position" do
      whitepiece = FactoryBot.create(:piece, location_x: 0, location_y: 1)

      patch :update, params: { game_id: whitepiece.game_id, id: whitepiece.id, piece: { location_x: 0, location_y: 2 } }
      expect(response).to redirect_to new_user_session_path

      whitepiece.reload
      expect(whitepiece.location_x).to eq(0)
      expect(whitepiece.location_y).to eq(1)
    end

    it "should allow only game players update a piece's position" do
      whitepiece = FactoryBot.create(:piece, location_x: 0, location_y: 1)
      user_not_player = FactoryBot.create(:white_player)
      sign_in user_not_player

      patch :update, params: { game_id: whitepiece.game_id, id: whitepiece.id, piece: { location_x: 0, location_y: 2 } }
      expect(response).to have_http_status(:forbidden)

      whitepiece.reload
      expect(whitepiece.location_x).to eq(0)
      expect(whitepiece.location_y).to eq(1)
    end

    it "should allow only white player update a white piece's position" do
      whitepiece = FactoryBot.create(:piece, location_x: 0, location_y: 1)
      bplayer = FactoryBot.create(:white_player)
      sign_in bplayer

      patch :update, params: { game_id: whitepiece.game_id, id: whitepiece.id, piece: { location_x: 0, location_y: 2 } }
      expect(response).to have_http_status(:forbidden)

      whitepiece.reload
      expect(whitepiece.location_x).to eq(0)
      expect(whitepiece.location_y).to eq(1)
    end

    it "should allow only black player update a black piece's position" do
      bplayer = FactoryBot.create(:white_player)
      game = FactoryBot.create(:game, black_player_id: bplayer.id)
      blackpiece = Piece.find_by(location_x: 0, location_y: 6)
      sign_in game.white_player

      patch :update, params: { game_id: blackpiece.game_id, id: blackpiece.id, piece: { location_x: 0, location_y: 5 } }
      expect(response).to have_http_status(:forbidden)

      blackpiece.reload
      expect(blackpiece.location_x).to eq(0)
      expect(blackpiece.location_y).to eq(6)
    end

    it "should update the piece's position" do
      whitepiece = FactoryBot.create(:piece, location_x: 0, location_y: 0)
      sign_in whitepiece.game.white_player

      patch :update, params: { game_id: whitepiece.game_id, id: whitepiece.id, piece: { location_x: 0, location_y: 2 } }
      expect(response).to redirect_to game_path(whitepiece.game)

      whitepiece.reload
      expect(whitepiece.location_x).to eq(0)
      expect(whitepiece.location_y).to eq(2)
    end

    it "should return a NotFound(404) error if the piece was not found" do
      whitepiece = FactoryBot.create(:piece, location_x: 0, location_y: 0)
      sign_in whitepiece.game.white_player

      patch :update, params: { game_id: whitepiece.game_id, id: 'BOOBOO', piece: { location_x: 0, location_y: 2 } }
      expect(response).to have_http_status(:not_found)

      whitepiece.reload
      expect(whitepiece.location_x).to eq(0)
      expect(whitepiece.location_y).to eq(0)
    end
  end
end
