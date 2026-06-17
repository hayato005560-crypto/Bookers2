class BooksController < ApplicationController
  
  def index
    @books = Book.all
    @book = Book.new
    @user = Current.user
  end

  def show
    @book = Book.find(params[:id])
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

  def create
    @book = Book.new(book_params)
    @book.user_id = Current.user.id

    if @book.save
      redirect_to book_path(@book), notice: "Book was successfully created."
    else
      flash.now[:alert] = "Book creation error."
      @books = Book.all.order(created_at: :asc)
      @user = Current.user
      render :index, status: :unprocessable_entity
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

  def destroy
    @book = Book.find(params[:id])

    if @book.user != Current.user
      redirect_to books_path
      return
    end

    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end