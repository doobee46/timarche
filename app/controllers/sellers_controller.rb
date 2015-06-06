class SellersController < ApplicationController
  respond_to :html, :json

  def index
    @users = User.all
    @sellers  =@users.where("users.listings_count >=1").paginate(:page => params[:page], :per_page => 30)
    @q = Listing.includes(:user, :impressions, :like, :category).search(params[:q])
    @listings= @q.result.paginate(:page => params[:page], :per_page => 30)
    respond_with(@sellers)
  end

  def show
      @user = User.find_by_username(params[:id]) 
      @listings= @user.listings.paginate(:page => params[:page], :per_page => 30)
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
