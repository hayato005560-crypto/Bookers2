class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    book_comment = book.book_comments.new(book_comment_params)
    book_comment.user_id = Current.user.id
    book_comment.save
    redirect_back(fallback_location: book_path(book))
  end

  def destroy
    book = Book.find(params[:book_id])
    book_comment = Current.user.book_comments.find_by(id: params[:id], book_id: book.id)
    book_comment.destroy if book_comment
    redirect_back(fallback_location: book_path(book))
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
  
end