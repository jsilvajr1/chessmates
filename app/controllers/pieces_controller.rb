class PiecesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :update]
  
  def create
  end

  def show
    @piece = Piece.find_by_id(params[:id])
    return render_not_found if @piece.blank?

    if @piece.white
      return render plain: 'Not Allowed!', status: :forbidden if current_user != @piece.game.white_player
    else
      return render plain: 'Not Allowed!', status: :forbidden if current_user != @piece.game.black_player
    end
  end

  def update
    @piece = Piece.find_by_id(params[:id])
    return render_not_found if @piece.blank?

    if @piece.white
      return render plain: 'Not Allowed!', status: :forbidden if current_user != @piece.game.white_player
    else
      return render plain: 'Not Allowed!', status: :forbidden if current_user != @piece.game.black_player
    end

    @piece.update_attributes(piece_params)
    redirect_to game_path(@piece.game)
  end

  private

  def piece_params
    params.require(:piece).permit(:game_id, :location_x, :location_y, :white)
  end
end
