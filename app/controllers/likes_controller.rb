class LikesController < ApplicationController
  before_filter :authenticate_user!

  def create
  	 @like = Like.new(like_params)
     respond_to do|format|
  	 if@like.save
         current_user.create_activity(@like, "like")
       format.js
  	 else
  	    format.html (redirect_to root_url , notice:"Unable to proceed")
        format.js
  	 end
    end
  end

  private

  def like_params
  	params.require(:like).permit(:listing_id)
  end
  
end
