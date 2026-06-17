class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_path, alert: "Try again later." }

  def new
  end

  def create
    if user = User.authenticate_by(params.permit(:name, :password))
      start_new_session_for user
      redirect_to user_path(user), notice: "Signed in successfully."
    else
      redirect_to new_session_path, alert: "Login error."
    end
  end

  def destroy
    terminate_session
    redirect_to root_path, notice: "Signed out successfully."
  end
end
