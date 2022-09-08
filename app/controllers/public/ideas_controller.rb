class Public::IdeasController < ApplicationController
 # before_action :authenticate_user!
 # before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
   @idea = Idea.new
  end

  def index
    @idea = Idea.new
    @public = current_user
    @ideas = Idea.all  
  end

  def show
  end

  def edit
  end
  
  def create
    @idea = Idea.new(idea_params)
    @idea.user_id = current_user.id
    if @idea.save
      redirect_to idea_path(@idea), notice: "You have created book successfully."
    else
      @ideas = Idea.all
      render "index"
    end
  end
  
    private
  def idea_params
    params.require(:idea).permit(:genre_id, :title, :body, :image)  
  end
end
