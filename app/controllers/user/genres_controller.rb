class User::GenresController < ApplicationController
  def index
    @genre = Genre.new
    @genres = Genre.all
  end
  
  def idea_genres
    @genres = Genre.all
    @genre = Genre.find(params[:idea_id])
    @genre_ideas = @genre.ideas.page(params[:page]).per(8)
  end


 private
  
  def genre_params
    params.require(:genre).permit(:name)#dbマイグレートで確認
  end
end