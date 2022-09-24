class Admin::IdeaCommentsController < ApplicationController
  before_action :if_not_admin

  def destroy
    @idea = Idea.find(params[:idea_id])
    @comment = IdeaComment.find(params[:id])
    @comment.destroy
  end

  private
    def comment_params
      params.require(:idea_comment).permit(:comment, :user_id, :idea_id)
    end
    
    def if_not_admin
      redirect_to root_path unless current_admin
    end
end
