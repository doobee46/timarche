class Users::RegistrationsController < Devise::RegistrationsController
  include ApplicationHelper

  def create
    super 
      @user.create_subscription()
      # Sends email to user when user is created.
      TimarcheMailer.delay.welcome_email(@user)
  end

  def new
    super
  end

  def edit
    super
  end
  
end
