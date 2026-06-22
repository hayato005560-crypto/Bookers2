class RelationshipsController < ApplicationController

   def create
     user = User.find(params[:relationship][:followed_id]) 
     Current.user.follow(user)
     redirect_back(fallback_location: user_path(user))
   end

   def destroy
     relationship = Current.user.active_relationships.find(params[:id])
     user = relationship.followed
     Current.user.unfollow(user)
     redirect_back(fallback_location: user_path(user))
   end

end
