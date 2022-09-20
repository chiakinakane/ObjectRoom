class User::UsersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]
  # いいね一覧表示
  # before_action :set_user, only: [:favorites]
  
  
  def show
    @user = User.find(params[:id])
    @ideas = @user.ideas
    @idea = Idea.new
    @genres = Genre.all
  end

  # def my_page
  #   @user = current_user
  #   @ideas = @user.ideas
  #   @idea = Idea.new
  #   render :show
  # end

  def index
    @users = User.all
    @idea = Idea.new
    @ideas = Idea.all
    @genres = Genre.all
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
  
  # いいね一覧表示
  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:idea_id)
    # pluckプラック　配列で返す
    @favorite_ideas = Idea.find(favorites)
  end
  
  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行致しました"
    redirect_to root_path
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
    # いいねした投稿を探し、@favorite_ideasに格納
    # def set_user
    #   @user = User.find(params[:id])
    # end
end
