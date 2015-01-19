class SellersController < ApplicationController
  before_filter :set_search
  def index
    @q = User.all
  	@sellers  =@q.result.paginate(:page => params[:page], :per_page => 30)
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

  private

    def set_search
      @q=Listing.search(params[:q])
    end

end
