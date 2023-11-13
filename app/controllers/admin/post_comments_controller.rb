class Admin::PostCommentsController < ApplicationController
  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to request.referer, notice: 'コメントを削除しました。'
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
