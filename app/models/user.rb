class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # 
    
  extend FriendlyId
  friendly_id :name, use: :slugged 
    
  acts_as_commontator
  acts_as_messageable
  # Added by Koudoku.
  has_one  :subscription
  devise   :omniauthable, :omniauth_providers => [:facebook]
  has_many :listings, dependent: :destroy
  has_many :activities
  has_many :relationships,foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed

  has_many :reverse_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy                               
  
  has_many :followers, through: :reverse_relationships, source: :follower
    
  has_many :notifications, foreign_key: :recipient_id , dependent: :destroy
   
  has_many :hearts, dependent: :destroy
  #has_many :listings, through: :hearts,dependent: :destroy
  
  has_attached_file :avatar, :styles => { :athumb => "30x30#",:amedium =>"120x120#",:alarge =>"260X208#" }, :default_url => "default_:style.png"
  
  validates :username, uniqueness: true
  validates :email, uniqueness: true, presence: true  
    
  #validates_attachment :avatar, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png","image/jpg"] }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  do_not_validate_attachment_file_type :avatar
  Paperclip.options[:content_type_mappings] = {nil => "image/png"}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :login
  
  #->Prelang (user_login:devise/username_login_support)
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.downcase}]).first
    else
      where(conditions).first
    end
  end

  devise authentication_keys: [:login]

 
  def mailboxer_email(object)
     email
  end

  def self.from_omniauth(auth)
    if user = User.find_by_email(auth.info.email)
      if auth.info.image.present?
        user.update_attribute(:avatar, process_uri(auth.info.image))
      end
      user
    else # Create a user with a stub password. 
      User.create!(:email => auth.info.email,
                   :name => auth.info.name,
                   :username => auth.info.name,
                   :password => Devise.friendly_token[0,20],
                   :avatar => process_uri(auth.info.image))
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if omniauth = session["devise.facebook_data"]
        user.email = auth.info.email
        user.name = auth.info.name
        user.avatar = auth.info.image
        user.username= auth.info.nickname
      end
    end
  end


 
  def following?(other_user)
  relationships.find_by(followed_id: other_user.id)
  end
  
  def follow!(other_user)
  relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
  relationships.find_by(followed_id: other_user.id).destroy
  end
    
    def create_activity(item, action)
        activity = activities.new 
        activity.targetable = item
        activity.action =action
        activity.save
        activity 
    end

   def total_views
        views=[]
        listings.each do |listing|
            views.push(listing.impressions_count)
        end
        total = views.inject(0){|r,s| r+s}
        total
   end
  
  # creates a new heart row with listing_id and user_id
    def heart!(listing)
      self.hearts.create!(listing_id: listing.id)
    end

    # destroys a heart with matching listing_id and user_id
    def unheart!(listing)
      heart = self.hearts.find_by_listing_id(listing.id)
      heart.destroy!
    end

    # returns true of false if a listing is hearted by user
    def heart?(listing)
      self.hearts.find_by_listing_id(listing.id)
    end
  
 def self.list(id)
      list = []
      user= User.find(id)
      listings = Listing.all
      listings.each do |listing|
        if listing.user_id == id
          list << listing
        end
      end
      return list 
  end  
  
 
  private

  def self.process_uri(uri)
    require 'open-uri'
    require 'open_uri_redirections'
    open(uri, :allow_redirections => :safe) do |r|
      r.base_uri.to_s
    end
  end




 
end
