class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]

  def new
      @user = User.new
  end

  def create
      @user = User.new(user_params)

      if @user.save
          redirect_to new_session_path
      else
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
  end

  def edit
      @user = User.find(params[:id])
  end

  def update
      @user = User.find(params[:id])
      if @user.update(user_params)
          redirect_to user_path(@user)
      else
          render :edit,status: :unprocessable_entity
      end
  end

  private

  def user_params
      params.require(:user).permit(:name, :introduction, :email_address, :password, :password_confirmation, :profile_image)
  end

end
