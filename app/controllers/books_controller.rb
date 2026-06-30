class BooksController < ApplicationController
  
  def index
    @books = Book.all
    @book = Book.new
    @user = Current.user

    @last_7_days_book_counts = (0..6).map do |i|
      days_ago = 6 - i
      date = days_ago.days.ago.to_date

      {
        label: days_ago == 0 ? "今日" : "#{days_ago}日前",
        count: Book.where(created_at: date.all_day).count
      }
    end
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
    @book = Book.new(book_params)
    @book.user = Current.user
  
    if @book.save
      redirect_to book_path(@book), notice: "Book was successfully created."
    else
      @books = Book.all
      @user = Current.user
      render :index, status: :unprocessable_entity
    end    
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end