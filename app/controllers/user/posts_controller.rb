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
      flavor_genre = params[:flavor_genre]
      @posts = flavor_genre ? Post.where(flavor_genre: flavor_genre) : Post.all
    end
    
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
end