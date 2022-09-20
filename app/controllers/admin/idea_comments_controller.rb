class Admin::IdeaCommentsController < ApplicationController
   

  def destroy
    @idea = Idea.find(params[:idea_id])
    @comment = IdeaComment.find(params[:id])
    @comment.destroy
    flash.now[:notice] = "コメントを削除しました。"
  end

  private
    def comment_params
      params.require(:idea_comment).permit(:comment, :user_id, :idea_id)
    end
end
