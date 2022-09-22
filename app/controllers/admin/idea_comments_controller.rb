class Admin::IdeaCommentsController < ApplicationController
  # before_action :authenticate_user!, only: [:destroy]
  before_action :if_not_admin
  # before_action :set_idea, only: [:destroy]

  def destroy
    @idea = Idea.find(params[:idea_id])
    @comment = IdeaComment.find(params[:id])
    #byebug
    @comment.destroy
    #flash.now[:notice] = "コメントを削除しました。"
    #redirect_to request.referer
  end

  private
    def comment_params
      params.require(:idea_comment).permit(:comment, :user_id, :idea_id)
    end
    
    def if_not_admin
      redirect_to root_path unless current_admin
    end
    
    # def set_idea
    #   @idea= Idea.find(params[:id])
    # end
end
