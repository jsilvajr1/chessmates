class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy]

  def index
    @games = Game.available
  end

  def new
    @game = Game.new
  end

  def create
    @game = current_user.initiated_games.create(game_params)

    if @game.valid?
    redirect_to root_path
    else
    render :new, status: :unprocessable_entity
    end

    @game.populate_game!
  end

  def show
    @game = Game.find_by_id(params[:id])
    return render_not_found if @game.blank?

    @piece = @game.pieces.find_by_location_x_and_location_y(params[:location_x],params[:location_y])
  end

  def update
    @game = Game.find_by_id(params[:id])
    return render_not_found if @game.blank?

    @game.update_attributes(black_player_id: current_user.id)

    if @game.black_player_joined?
      flash[:notice] = 'You joined the game succesfully'
      redirect_to game_path(@game)
    else
      flash[:alert] = 'You did not join the game. Please try again'
    end
  end

  def destroy
    @game = Game.find_by_id(params[:id])
    return render_not_found if @game.blank?

    if @game.white_player != current_user
      return render plain: 'Not Allowed!', status: :forbidden
    end

    @game.destroy
    redirect_to root_path
  end

  private

  def game_params
    params.require(:game).permit(:game_name, :black_player_id)
  end
end
