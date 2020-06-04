class RelationshipsController < ApplicationController
	 def create
         current_user.follow(params[:id])
         redirect_to user_path
     end

     def destroy
      user = User.find(params[:id])
         current_user.unfollow(user)
         redirect_to user_path(user.id)
     end


	 def follow_index
       current_user.follow(params[:id])
       @user = User.find(params[:id])
   end

    def unfollow_index
        current_user.unfollow(params[:id])
        @user = User.find(params[:id])
    end
end
