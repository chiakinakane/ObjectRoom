class Admin::UsersController < ApplicationController
   # before_action :authenticate_admin!
  
   # layout "admin_application"
    
   def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "会員情報を編集しました"
    else
      render "edit"
    end
  end

  private

  def customer_params
    params.require(:user).permit(:last_name, :first_name, :kana_last_name, :kana_first_name, :email, :is_deleted)
  end
end
