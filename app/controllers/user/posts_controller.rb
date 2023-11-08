class User::PostsController < ApplicationController
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
    if params[:latest]
      @posts = Post.latest
    elsif params[:old]
      @posts = Post.old
    elsif params[:star_count]
      @posts = Post.star_count
    else
    @posts = Post.all
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

 private

  def post_params
    params.require(:post).permit(:title, :body, :flavor_genre, :player, :location, :hms_genre, :top_genre, :duration, :price, :flavor_capacity, :flavor_maker, :smoking_level, :smoking_taste_level, :bottle_option, :nicotine, :star)
  end
end