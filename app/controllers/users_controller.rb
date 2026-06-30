class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]

  def new
      @user = User.new
  end

  def create
      @user = User.new(user_params)

      if @user.save
          start_new_session_for @user
          redirect_to user_path(@user), notice: "User was successfully created."
      else
          flash.now[:alert] = "User registration error."
          render :new, status: :unprocessable_entity
      end
  end
    


  def index
      @users =User.all
      @user = Current.user
      @book = Book.new
  end

  def show
      @user = User.find(params[:id])
      @books = @user.books
      @book = Book.new

      @today_book_count = @books.where(created_at: Time.current.all_day).count
      @yesterday_book_count = @books.where(created_at: 1.day.ago.all_day).count

      if @yesterday_book_count == 0
        @day_comparison = "前日の投稿はありません"
      else
        @day_comparison = (@today_book_count.to_f / @yesterday_book_count *100).round
      end

      @this_week_book_count = @books.where(created_at: 6.days.ago.beginning_of_day..Time.current.end_of_day).count
      @last_week_book_count = @books.where(created_at: 13.days.ago.beginning_of_day..7.days.ago.end_of_day).count

      if @last_week_book_count == 0
        @week_comparison = "先週の投稿はありません"
      else
        @week_comparison = (@this_week_book_count.to_f / @last_week_book_count * 100).round
      end
  end

  def edit
      @user = User.find(params[:id])

      if @user != Current.user
          redirect_to user_path(Current.user)
          return
      end
  end

  def update
      @user = User.find(params[:id])

      if @user != Current.user
          redirect_to user_path(Current.user)
          return
      end

      if @user.update(user_params)
          redirect_to user_path(@user), notice: "User was successfully updated."
      else
          flash.now[:alert] = "User update error."
          render :edit, status: :unprocessable_entity
      end
  end

  def follows
      @user = User.find(params[:id])
      @users = @user.followings
      @book = Book.new
  end

  def followers
      @user = User.find(params[:id])
      @users = @user.followers
      @book = Book.new
  end

  private

  def user_params
      params.require(:user).permit(:name, :introduction, :email_address, :password, :password_confirmation, :profile_image)
  end

end
