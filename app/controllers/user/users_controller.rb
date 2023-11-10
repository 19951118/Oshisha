class User::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def index
    @users = User.all
    @post = Post.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザ情報を更新しました！"
    else
      render "edit"
    end
  end

  def destroy
      @user = User.find(params[:id]) 
      @user.destroy
      flash[:notice] = 'ユーザーを削除しました。'
      redirect_to :root 
  end
  
  def favorites
    @user = User.find(params[:id])
    favorites= Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile, :profile_image, :shisha_resistance)
  end

end
