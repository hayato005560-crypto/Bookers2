class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.new(book_comment_params)
    @book_comment.user = Current.user

    if @book_comment.save
      redirect_back(fallback_location: book_path(@book))
    else
      redirect_back(fallback_location: book_path(@book), alert: "コメントの投稿に失敗しました")
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.find(params[:id])
    @book_comment.destroy

    @new_book_comment = BookComment.new

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to book_path(@book) }
    end
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
  
end