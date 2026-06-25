class BooksController < ApplicationController
  
  def index
    @books = Book.all
    @book = Book.new
    @user = Current.user
  end

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    @user = @book.user
    @new_book = Book.new
  end

  def edit
    @book = Book.find(params[:id])

    if @book.user != Current.user
      redirect_to books_path
      return
    end
  end

    def update
    @book = Book.find(params[:id])

    if @book.user != Current.user
      redirect_to books_path
      return
    end

    if @book.update(book_params)
      redirect_to book_path(@book), notice: "Book was successfully updated."
    else
      flash.now[:alert] = "Book update error."
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.new(book_comment_params)
    @book_comment.user = Current.user
    @book_comment.save

    @new_book_comment = BookComment.new

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to book_path(@book) }
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