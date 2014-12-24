class PagesController < ApplicationController
  
  before_filter :authenticate_user!, except: [:about, :index, :contact]
  respond_to :html

  def index
    @listings = Listing.all
    @indexes = @listings.order('created_at DESC').limit(3)
  end

  def about
  end

  def contact
  end

  def browse
  	@listings = Listing.all.paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
    @messages_count = current_user.mailbox.inbox({:read => false}).count

    respond_with(@listings)

  end
  
end
