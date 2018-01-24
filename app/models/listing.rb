class Listing < ActiveRecord::Base
   
  is_impressionable :counter_cache => true, :column_name => :impressions_count, :unique => true
  acts_as_commontable

  belongs_to :user, counter_cache: :listings_count
  belongs_to :category
  has_many   :pictures, dependent: :destroy
  has_many   :like, dependent: :destroy
  has_many   :activities
  has_many   :notifications, as: :notifiable , dependent: :destroy
  
  has_many   :hearts, dependent: :destroy
  has_many   :users, through: :hearts 
  
  #include SimpleRecommender::Recommendable
  #similar_by :users
  
  scope :published,->{where("listings.created_at IS NOT NULL ")}
  scope :recent, lambda{published.where(:created_at == ((Time.now.midnight - 1.day)..Time.now.midnight))}
  scope :popular, ->{where("listings.impressions_count >= 30").order("impressions_count DESC")}
  
  validates :name, presence: true
  validates :description, presence: true 
  validates :price, presence: true
   
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
  def self.limit
    if @user.listings(:reload).count >= 10
      errors.add(:base, " limit")
      flash[:notice] = "Welcome to the Sample App!"
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
