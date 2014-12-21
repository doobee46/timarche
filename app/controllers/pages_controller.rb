class PagesController < ApplicationController
  
  before_filter :authenticate_user!, except: [:about, :index]
  respond_to :html

  def index
    @listings = Listing.all
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
