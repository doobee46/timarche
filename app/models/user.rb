class User < ActiveRecord::Base
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


end
