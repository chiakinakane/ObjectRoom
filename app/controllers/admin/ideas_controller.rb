class Admin::IdeasController < ApplicationController

  before_action :if_not_admin
  before_action :set_idea, only: [:destroy]
  
  
  def index
    @ideas = Idea.all 
    @genres = Genre.all
  end
  
    
  def show
    @idea_new = Idea.new
    @idea = Idea.find(params[:id])
    @idea_image = @idea.image
    @genres = Genre.all
    # コメント一覧表示で使用する全コメントデータを代入（新着順で表示）
    #binding.pry
    @comments = @idea.idea_comments.order(created_at: :desc)
    # コメントの作成
    @comment = IdeaComment.new
    #右側はmodel名を記述
  end
  
  #非同期のためredirect_toの記述なし
  def destroy
    @idea = Idea.find(params[:id])
    @ideas = Idea.all
    @idea.destroy
  end
  
  private
    def if_not_admin
      redirect_to root_path unless current_admin
    end
    
    def set_idea
      @idea= Idea.find(params[:id])
    end
end