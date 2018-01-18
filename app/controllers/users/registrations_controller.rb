class Users::RegistrationsController < Devise::RegistrationsController
  include ApplicationHelper

  def create
    super 
      @user.create_subscription()
      if @user.save
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
