class User < ActiveRecord::Base
  devise :omniauthable, :omniauth_providers => [:facebook]
  has_many :listings, dependent: :destroy
  acts_as_commontator
  acts_as_messageable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  extend FriendlyId
  friendly_id :name, use: :slugged  


  if Rails.env.development?
     has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "30x30#" }, :default_url => "avatar.png"
  else
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "30x30#" }, :default_url => "avatar.png",
                    :storage => :dropbox,
                    :dropbox_credentials => Rails.root.join("config/dropbox.yml")
  end

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
 

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

  def name
    username
  end

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
                 :username => auth.info.nickname,
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
    end
  end
end

private

def self.process_uri(uri)
  require 'open-uri'
  require 'open_uri_redirections'
  open(uri, :allow_redirections => :safe) do |r|
    r.base_uri.to_s
  end
end



=begin
def self.from_omniauth(auth, signed_in_resource=nil)
    user = User.where(:email => auth.email).first() 
    #user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
    user = User.create(name:auth.extra.raw_info.name,
                         provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email,
                         password:Devise.friendly_token[0,20]
                         )
    end
  end
=end

=begin
  def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.name = auth.info.name   # assuming the user model has a name
    #user.avatar = auth.info.image # assuming the user model has an image
  end
=end
  
=begin

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
=end
 
end
