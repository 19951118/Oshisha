class Admin::PostsController < ApplicationController
  before_action :authenticate_admin! 
  def index
    @search_params = post_search_params
    @post = case
            when params[:latest]
              Post.search(@search_params).latest
            when params[:old]
              Post.search(@search_params).old
            when params[:star_count]
              Post.search(@search_params).star_count
            else
              Post.search(@search_params)
            end
    @posts = @post.page(params[:page]).per(10)
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
