class Users::RegistrationsController < Devise::RegistrationsController
  include ApplicationHelper

  def create
    super
    if @user.save
      # Sends email to user when user is created.
      TimarcheMailer.welcome_email(@user).deliver
    end
  end

  def new
    super
  end

  def edit
    super
  end
  
end
