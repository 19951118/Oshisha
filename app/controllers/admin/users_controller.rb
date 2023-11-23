class Admin::UsersController < ApplicationController
   before_action :authenticate_admin! 
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = 'ユーザーを削除しました。'
    redirect_to "/admin"
  end

  def update
     @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "ユーザ情報を更新しました！"
    else
      render "admin/edit"
    end
  end

   private

  def user_params
    params.require(:user).permit(:name, :profile, :profile_image, :shisha_resistance, :is_active)
  end
end
