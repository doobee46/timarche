class RelationshipsController < ApplicationController
	
    def create
		@user = User.find(params[:relationship][:followed_id])
		current_user.follow!(@user)
        #current_user.create_activity(@user, "follow")
        Notification.create(recipient: @user, actor: current_user, action: "following", notifiable: @user)
		respond_to do |format|
		format.html { redirect_to @user }
		format.js
		end
	end

	def destroy
		@user = Relationship.find(params[:id]).followed
		current_user.unfollow!(@user)
		respond_to do |format|
		format.html { redirect_to @user }
		format.js
		end
	end

end
