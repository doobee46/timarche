class Listing < ActiveRecord::Base
   
  is_impressionable :counter_cache => true, :column_name => :impressions_count, :unique => true
  acts_as_commontable

  belongs_to :user, counter_cache: :listings_count
  belongs_to :category
  has_many   :pictures, dependent: :destroy
  has_many   :like, dependent: :destroy
  
  scope :published,->{where("listings.created_at IS NOT NULL ")}
  scope :recent, lambda{published.where("created_at >= ?", Time.zone.now.beginning_of_day)}
  scope :popular, ->{where("listings.impressions_count >= 2").order("impressions_count desc")}

  extend FriendlyId
  friendly_id :name, use: :slugged

  if Rails.env.development?
    has_attached_file :image, :styles => { :large=> "564x394#",:medium => "208x200#", :thumb => "100x100>", :avatar =>"64x64#", }, :default_url => "default_:style.png"
  else
    has_attached_file :image, :styles => { :large=> "564x394#",:medium => "208x200#", :thumb => "100x100>", :avatar =>"64x64>", }, :default_url => "default_:style.png",
                      :storage => :dropbox,
                      :dropbox_credentials => Rails.root.join("config/dropbox.yml")
  end
  #validates_attachment :image, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png","image/jpg"] }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  #validate :listing_limit, :on => :create
  do_not_validate_attachment_file_type :image

  attr_default :listing_number do
    year=Date.current.year
    "TM#{year}HT".to_s
  end

=begin
  def listing_limit
    if self.user.listings(:reload).count >= 1
      errors.add(:base, "Exceeded thing limit")
    end
  end
=end


end
