class RoomsController < ApplicationController
  def create
    @user = User.find(params[:user_id])

    unless Current.user.mutual_follow?(@user)
      redirect_to user_path(@user), alert: "相互フォローしているユーザーとのみDMできます。"
      return
    end

    room = Current.user.rooms
                       .where(id: @user.rooms.select(:id))
                       .first

    unless room
      Room.transaction do
        room = Room.create!

        Entry.create!(
          user: Current.user,
          room: room
        )

        Entry.create!(
          user: @user,
          room: room
        )
      end
    end

    redirect_to room_path(room)
  end
end
