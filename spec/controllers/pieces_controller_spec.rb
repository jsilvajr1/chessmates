require 'rails_helper'

RSpec.describe PiecesController, type: :controller do

  describe "show#pieces action" do
  
    it "should display the show page for the piece that was clicked" do
      piece1 = FactoryBot.create(:piece)

      get :show, params: { game_id: piece1.game_id, id: piece1.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a NotFound(404) error if the piece was not found" do
      piece1 = FactoryBot.create(:piece)

      get :show, params: { game_id: piece1.game_id, id: 'BOOBOO' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "update#pieces action" do

    it "should update the piece's position" do
      piece1 = FactoryBot.create(:piece, location_x: 0, location_y: 0)

      patch :update, params: { game_id: piece1.game_id, id: piece1.id, piece: { location_x: 7, location_y: 7 } }
      expect(response).to redirect_to game_path(piece1.game)

      piece1.reload
      expect(piece1.location_x).to eq(7)
      expect(piece1.location_y).to eq(7)
    end

    it "should return a NotFound(404) error if the piece was not found" do
      piece1 = FactoryBot.create(:piece, location_x: 0, location_y: 0)

      patch :update, params: { game_id: piece1.game_id, id: 'BOOBOO', piece: { location_x: 7, location_y: 7 } }
      expect(response).to have_http_status(:not_found)

      piece1.reload
      expect(piece1.location_x).to eq(0)
      expect(piece1.location_y).to eq(0)
    end
  end
end
