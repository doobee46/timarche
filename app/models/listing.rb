class Listing < ActiveRecord::Base
   
  is_impressionable
  acts_as_commontable
  belongs_to :user
  belongs_to :category
  has_many   :pictures
  has_many   :like

  extend FriendlyId
  friendly_id :name, use: :slugged

  if Rails.env.development?
    has_attached_file :image, :styles => { :large=> "564x394#",:medium => "208x200#", :thumb => "100x100>", :avatar =>"64x64#", }, :default_url => "default_:style.png"
  else
    has_attached_file :image, :styles => { :large=> "564x394#",:medium => "208x200#", :thumb => "100x100>", :avatar =>"64x64>", }, :default_url => "default_:style.png",
                      :storage => :dropbox,
                      :dropbox_credentials => Rails.root.join("config/dropbox.yml")
  end
   validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
=begin
  def set_listing_number
    listing_number=("TM#{year}HT#{n+1}#{id}").to_s
  end
=end
  
  attr_default :listing_number do
    year=Date.current.year
    "TM#{year}HT#{id}".to_s
  end



end
