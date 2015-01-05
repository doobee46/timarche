class Listing < ActiveRecord::Base
   
  is_impressionable :counter_cache => true, :column_name => :impressions_count, :unique => true
  acts_as_commontable
  belongs_to :user, counter_cache: :listings_count
  belongs_to :category
  has_many   :pictures
  has_many   :like
  
  scope :published,->{where("listings.created_at IS NOT NULL ")}
  scope :recent, lambda{published.where("listings.created_at > ?", 1.week.ago.to_date)}
  scope :popular, ->{where("listings.impressions_count >= 5").order("impressions_count desc")}

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
