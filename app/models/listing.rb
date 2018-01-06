class Listing < ActiveRecord::Base
   
  is_impressionable :counter_cache => true, :column_name => :impressions_count, :unique => true
  acts_as_commontable

  belongs_to :user, counter_cache: :listings_count
  belongs_to :category
  has_many   :pictures, dependent: :destroy
  has_many   :like, dependent: :destroy
  has_many   :activities
  
  scope :published,->{where("listings.created_at IS NOT NULL ")}
  scope :recent, lambda{published.where("created_at >= ?", (Date.today))}
  scope :popular, ->{where("listings.impressions_count >=5").order("impressions_count DESC")}

  extend FriendlyId
  friendly_id :name, use: :slugged

  
  has_attached_file :image, :styles => { :large=> "564x394#",:medium => "208x200#", :thumb => "100x100>", :avatar =>"64x64#", }, :default_url => "default_:style.png"
  
  #validates_attachment :image, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png","image/jpg"] }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  #validate :listing_limit, :on => :create
  do_not_validate_attachment_file_type :image
  Paperclip.options[:content_type_mappings] = {nil => "image/png"}

  attr_default :listing_number do
    t = Time.now
    year=Date.current.year
    hour = t.strftime('%m%d%H%M%S') + rand(100).to_s
    "TM#{year}-HT#{hour}".to_s 
  end

=begin
  def listing_limit
    if self.user.listings(:reload).count >= 1
      errors.add(:base, "Exceeded thing limit")
    end
  end
=end
 
  def self.getcategories(id)
     listings = Listing.all
     category_list =[]
     listings.each do |listing|
        if  listing.category_id == id
         category_list.push(listing)
        end
     end
     return category_list
 end


end
