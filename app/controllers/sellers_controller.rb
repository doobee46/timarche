class SellersController < ApplicationController
  def index
  	@sellers  = User.all.paginate(:page => params[:page], :per_page => 30)
    @listings = Listing.all.paginate(:page => params[:page], :per_page => 30)
  end

  def show
  	@user = User.find_by_username(params[:id])
  	@listings = @user.listings.paginate(:page => params[:page], :per_page => 30)
  end

  def following
    @user  = User.find_by_username(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @user  = User.find_by_username(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end


end
