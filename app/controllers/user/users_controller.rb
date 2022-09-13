class User::UsersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]
  def show
    @user = User.find(params[:id])
    @ideas = @user.ideas
    @idea = Idea.new
  end

  def my_page
    @user = current_user
    @ideas = @user.ideas
    @idea = Idea.new
    render :show
  end

  def index
    @users = User.all
    @idea = Idea.new
    @ideas = Idea.all
  end # 2end抜け

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "会員情報を編集しました"
    else
      render "edit"
    end
  end
  

  private
    def user_params
      params.require(:user).permit(:last_name, :first_name, :kana_last_name, :kana_first_name, :email, :encrypted_password, :introduction, :profile_image, :is_deleted)
    end

    def ensure_correct_user
      @user = User.find(params[:id])
      unless @user == current_user
        redirect_to user_path(current_user)
      end
    end
    
    def ensure_guest_user
      @user = User.find(params[:id])
      if @user.name == "guestuser"
        redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      end
    end
end
