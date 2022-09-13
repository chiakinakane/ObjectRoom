class User::IdeaCommentsController < ApplicationController
  def create
    # byebug
    # コメントをする対象の投稿(travel_record)のインスタンスを作成
    @idea = Idea.find(params[:idea_id])
    #投稿に紐づいたコメントを作成
    @comment = @idea.idea_comments.new(comment_params)
    # コメント投稿者(user)のidを代入
    @comment.user_id = current_user.id
    if @comment.save
      flash.now[:notice] = "コメントの投稿に成功しました。"
      render :index
    else
      flash.now[:alert] ="コメントの投稿に失敗しました。"
      render :index
    end
  end

  def destroy
    @comment = IdeaComment.find(params[:id])
    @comment.destroy
    flash.now[:notice] = "コメントを削除しました。"
    render :index
  end

  private
    def comment_params
      params.require(:idea_comment).permit(:comment, :user_id, :idea_id)
    end
end
