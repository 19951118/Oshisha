class Admin::PostsController < ApplicationController
  before_action :authenticate_admin! 
  def index
    if params[:latest]
      @posts = Post.latest
    elsif params[:old]
      @posts = Post.old
    elsif params[:star_count]
      @posts = Post.star_count
    else
      @search_params = post_search_params
      @posts = Post.search(@search_params)
    end
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path, notice: "投稿を削除しました！"
  end
  
  
  private

  def post_params
    params.require(:post).permit(:title, :body, :flavor_genre, :player, :location, :hms_genre, :top_genre, :duration, :price, :flavor_capacity, :flavor_maker, :smoking_level, :smoking_taste_level, :bottle_option, :nicotine, :star)
  end
  
  def post_search_params
    params.fetch(:search, {}).permit(:title, :flavor_genre, :player, :location, :hms_genre, :top_genre, :duration_from, :duration_to, :price_from, :price_to, :flavor_capacity_from, :flavor_capacity_to, :flavor_maker, :smoking_level, :smoking_taste_level, :bottle_option, :nicotine, :star)
  end
  
end