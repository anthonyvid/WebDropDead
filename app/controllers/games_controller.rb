class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.user = current_user
    @game.started_at = Time.current

    if @game.save
      auto_drop_dead = AutoDropDead.new
      @game_summary = auto_drop_dead.play_game(@game.number_of_sides, @game.number_of_dice, @game.number_of_players)
      @game.update(summary: @game_summary.to_json)
      redirect_to game_path(@game)
    else
      render :new
    end
  end

  def play
    @game = Game.find(params[:id])
  end

  def replay
    @game = Game.find(params[:id])
    @game.started_at = Time.current

    if @game.save
        auto_drop_dead = AutoDropDead.new
        @game_summary = auto_drop_dead.play_game(@game.number_of_sides, @game.number_of_dice, @game.number_of_players)
        @game.update(summary: @game_summary.to_json)
        redirect_to game_path(@game)
    else
        redirect_to game_path(existing_game), alert: "Could not reset the game."
    end
  end

  def history
    @games = current_user.games
  end

  def load
    @game = Game.find_by(id: params[:game_id], user: current_user)
    if @game
      render :show
    else
      redirect_to game_history_path, alert: "Game not found." 
    end
  end

  private

  def game_params
    params.require(:game).permit(:number_of_players, :number_of_sides, :number_of_dice, :started_at)
  end
end