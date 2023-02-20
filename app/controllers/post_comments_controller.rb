class PostCommentsController < ApplicationController
  
  def create
    book = Book.find(params[:book_id])
    comment = PostComment.new(post_comments_params)
    comment.user_id = current_user.id
    comment.book_id = book.id
    comment.save
    redirect_back fallback_location: root_path
  end
  
  def destroy
    PostComment.find(params[:id]).destroy
    redirect_back fallback_location: root_path
  end
  
  private
  
  def post_comments_params
    params.require(:post_comment).permit(:comment)
  end
  
end
