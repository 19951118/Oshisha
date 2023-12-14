class User::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_post_matching_login_user, only: [:edit, :update, :destroy]
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post), notice: "あなたの煙を投稿しました！"
    else
      render 'new'
    end
  end

  def index
    @search_params = post_search_params
    posts = Post.search(@search_params)
    if params[:search].present?
      case params[:search][:sort]
      when "latest"
        @posts = posts.latest
      when "old"
        @posts = posts.old
      when "star_count"
        @posts = posts.star_count
      when "favorite_count"
        @posts = posts.favorite_count
      else
        @posts = posts
      end
    else
      @posts = posts
    end
    @posts = @posts.page(params[:page]).per(10)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿を更新しました！"
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました！"
  end


 private

  def post_params
    params.require(:post).permit(:title, :body, :flavor_genre, :player, :location, :hms_genre, :top_genre, :duration, :price, :flavor_capacity, :flavor_maker, :smoking_level, :smoking_taste_level, :bottle_option, :nicotine, :star)
  end

  def post_search_params
    params.fetch(:search, {}).permit(:title, :flavor_genre, :player, :location, :hms_genre, :top_genre, :duration_from, :duration_to, :price_from, :price_to, :flavor_capacity_from, :flavor_capacity_to, :flavor_maker, :smoking_level, :smoking_taste_level, :bottle_option, :nicotine, :star, :latest, :old, :star_count)
  end

  def is_post_matching_login_user
    post = Post.find(params[:id])
    unless post.user == current_user
      redirect_to root_path
    end
  end

end
