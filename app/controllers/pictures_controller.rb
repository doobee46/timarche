class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @pictures = @listing.pictures
    respond_with(@pictures)
  end

  def show
    respond_with(@picture)
  end

  def new
    @picture = @listing.pictures.build
    respond_with(@picture)
  end

  def edit
     @picture = Picture.find(params[:id])
  end

  def create
    @picture = Picture.new(params[:picture])
    @picture.save
    respond_with(@picture)
  end

  def update
    @picture = @listing.pictures.find(params[:id])
    @picture.update_attributes(picture_params)
    respond_with(@picture)
  end

  def destroy
    @picture.destroy
    respond_with(@picture)
  end

  private
    def set_picture
      @listing =Listing.find(params[:listing_id]) 
    end

    def picture_params
      params.require(:picture).permit(:description, :listing_id, :image)
    end
end
