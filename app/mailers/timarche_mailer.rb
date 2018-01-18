class TimarcheMailer < ActionMailer::Base
  default from: "Equipe@timarche.com"
   def welcome_email(user)
   	 @user = user
     attachments.inline["mailer_bg.png"] = File.read(Rails.root.join('app/assets/images/mailer_bg.png'))
     attachments.inline["mailer_footer_bg.png"] = File.read(Rails.root.join('app/assets/images/mailer_footer_bg.png'))
   	 mail(to: @user.email, subject: "Bienvenue sur timarché")
   end
 end
