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
      @posts = Post.all
      render 'new'
    end
  end

  def index
    @post = Post.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def show
    @post = Post.find(params[:id])
  end

 private

  def post_params
    params.require(:post).permit(:title, :body, :flavor_genre, :player, :location, :hms_genre, :top_genre, :duration, :price, :flavor_capacity, :flavor_maker, :smoking_level, :smoking_taste_level, :bottle_option, :nicotine, :star)
  end
end