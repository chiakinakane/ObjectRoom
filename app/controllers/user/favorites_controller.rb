class User::FavoritesController < ApplicationController
    before_action :authenticate_user!, only: [:create, :destroy]
    before_action :idea_params, only: [:create, :destroy]
 
  def create
    Favorite.create(user_id: current_user.id, idea_id: @idea.id)
  end

  def destroy
    like = Favorite.find_by(user_id: current_user.id, idea_id: @idea.id)
    like.destroy
  end

  private
  def idea_params
    @idea = Idea.find(params[:idea_id])
  end
end
  
  

