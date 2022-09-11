class Admin::UsersController < ApplicationController
   def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @cuser = User.find(params[:id])
    if @cuser.update(user_params)
      redirect_to admin_cuser_path(@user), notice: "会員情報を編集しました"
    else
      render "edit"
    end
  end

  private

  def customer_params
    params.require(:user).permit(:last_name, :first_name, :kana_last_name, :kana_first_name, :email, :is_deleted)
  end
end
