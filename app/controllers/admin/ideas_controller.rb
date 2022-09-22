class Admin::IdeasController < ApplicationController

  #  before_action :authenticate_user!も必要なら書いてください！
  before_action :if_not_admin
  before_action :set_idea, only: [:destroy] #onlyのアクションは必要なものだけ書いてください
  
  
  def index
    @ideas = Idea.all 
    @genres = Genre.all
  end
  
    
  def show
    @idea_new = Idea.new
    @idea = Idea.find(params[:id])
    @idea_image = @idea.image
    @genres = Genre.all
    # current_user.name = "admin"
    
    # unless ViewCount.find_by(user_id: current_user.id, idea_id: @idea.id)
    #   current_user.view_counts.create(idea_id: @idea.id)
    # end
    #@idea_comment = IdeaComment.new
    
    
    # コメント一覧表示で使用する全コメントデータを代入（新着順で表示）
    #binding.pry
    @comments = @idea.idea_comments.order(created_at: :desc)
    # コメントの作成
    @comment = IdeaComment.new
    #右側はmodel名を
  end
  
  def destroy
    @idea = Idea.find(params[:id])
    @ideas = Idea.all
    @idea.destroy
    #redirect_to admin_ideas_path
    
  end
  
  private
    def if_not_admin
      redirect_to root_path unless current_admin
    end
    
    def set_idea
      @idea= Idea.find(params[:id])
    end
end