class PagesController < ApplicationController
  impressionist :actions=>[:index,:browse]
  before_filter :authenticate_user!, except: [:about, :index, :contact]
  respond_to :html, :json

  def index
   @listings = Listing.all
   @users=User.all
   respond_with(@listings)
  end

  def about
  end

  def contact
  end

  def browse
  	@listings = Listing.all.paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
    @messages_count = current_user.mailbox.inbox({:read => false}).count
    impressionist(@listings) 
    respond_with(@listings)

  end

  def set_picture
    @listing =Listing.friendly.find(params[:picture][:listing_id]) 
  end
  
end
