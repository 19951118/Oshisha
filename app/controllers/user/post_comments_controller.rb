class User::PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:book_id])
    @comment = current_user.post_comments.new(post_comment_params)
    @comment.post_id = @post.id
    @comment.save
  end
  
  def destroy
    @comment = PostComment.find(params[:id])
    PostComment.find(params[:id]).destroy
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
