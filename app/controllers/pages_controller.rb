class PagesController < ApplicationController
  before_filter :set_search
  before_filter :authenticate_user!, except: [:about, :index, :contact, :privacy]
  respond_to :html, :json

  def index
   @listings= @q.result
   @indexes = @listings.shuffle.sample(3)
   respond_with(@listings)
  end

  def about
  end

  def contact
  end

  def privacy
    
  end

  def browse
    @categories = Category.all
  	@listings= @q.result.paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
    @messages_count = current_user.mailbox.inbox({:read => false}).count
    respond_with(@listings)
  end

  def set_picture
    @listing =Listing.friendly.find(params[:picture][:listing_id]) 
  end

  def set_search
    @q=Listing.search(params[:q])
  end

end
