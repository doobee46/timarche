class LikesController < ApplicationController
  before_filter :authenticate_user!

  def create
  	 @like = Like.new(like_params)
  	 if@like.save
  	 	redirect_to @like.listing, notice:"save successfully"
  	 else
  	    redirect_to root_url , notice:"Unable to proceed"
  	 end
  end

  private

  def like_params
  	params.require(:like).permit(:listing_id)
  end
  
end
