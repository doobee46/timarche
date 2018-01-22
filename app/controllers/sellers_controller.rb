class SellersController < ApplicationController
  before_filter :set_user 
  respond_to :html, :json

  def index
    @users = User.all
    @sellers  =@users.where("users.listings_count >=1").paginate(:page => params[:page], :per_page => 30)
    @q = Listing.includes(:user, :impressions, :like, :category).search(params[:q])
    @listings= @q.result.paginate(:page => params[:page], :per_page => 30)
    respond_with(@sellers)
  end

  def show
      @user = User.friendly.find(params[:id]) 
      @lists = User.list(params[:id].to_i)
      @listings= Kaminari.paginate_array(@lists).page(params[:page]).per(30)
  end

  def following
    @user  = User.friendly.find.(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @user  = User.friendly.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end 

  private 
    
  def set_user
    @user = User.friendly.find(params[:id])
  end
    
 
end
