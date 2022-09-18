class User::IdeasController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  def new
   @idea = Idea.new
  end

  def index
    @idea = Idea.new
    @user = current_user
    @ideas = Idea.all  
    @genres = Genre.all
  end

  def show
    @idea_new = Idea.new
    @idea = Idea.find(params[:id])
    @idea_image = @idea.image
    @genres = Genre.all
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


  def edit
   @idea = Idea.find(params[:id])
  end
  
  def create
    @idea = Idea.new(idea_params)
    @idea.user_id = current_user.id
    #ユーザーのid のみ持ってくる記述を
    
    if @idea.save
      redirect_to idea_path(@idea.id), notice: "新しい投稿ができました。"
    else
      @ideas = Idea.all
      render "index"
    end
  end
  
  def update
    @idea = Idea.find(params[:id])
    if @idea.update(idea_params)
      redirect_to idea_path(@idea), notice: "投稿を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy
    redirect_to ideas_path
  end
  
    def genre_ideas
    @genres = Genre.all
    @genre = Genre.find(params[:idea_id])
    @genre_ideas = @genre.ideas.page(params[:page]).per(8)
  end
  
    private
  def idea_params
    params.require(:idea).permit(:user_id, :genre_id, :title, :body, :image)  
  end
  
  #投稿の紐付け
  def ensure_correct_user
  @idea = Idea.find(params[:id])
  unless @idea.user == current_user
    redirect_to ideas_path
  end
end

end

