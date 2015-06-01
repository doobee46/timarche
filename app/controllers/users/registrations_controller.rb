class Users::RegistrationsController < Devise::RegistrationsController
  include ApplicationHelper

  def create
    super 
      @user.create_subscription()
      if Rails.env.development?
          TimarcheMailer.welcome_email(@user).deliver
      else
      # Sends email to user when user is created.
      TimarcheMailer.delay.welcome_email(@user)
      end
  end

  def new
    super
  end

  def edit
    super
  end
  
end
