class Admin::IdeasController < ApplicationController
  
  #  before_action :authenticate_user!も必要なら書いてください！
  before_action :if_not_admin
  before_action :set_idea, only: [:destroy] #onlyのアクションは必要なものだけ書いてください
  
  #中略 def indexとか必要なものを書いてください！
  def index
    @ideas = Idea.all 
  end
  
  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy
    redirect_to admin_ideas_path
  end
  
  private
    def if_not_admin
      redirect_to root_path unless current_admin
    end
    
    def set_idea
      @idea= Idea.find(params[:id])
    end
end