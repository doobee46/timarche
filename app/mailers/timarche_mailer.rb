class TimarcheMailer < ActionMailer::Base
  default from: "Equipe@timarche.com"
   def welcome_email(user)
   	 @user = user
   	 mail(to: @user.email, subject: "Bienvenue sur timarché")
   end
 end
