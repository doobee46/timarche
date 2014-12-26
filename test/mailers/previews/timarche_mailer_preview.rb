# Preview all emails at http://localhost:3000/rails/mailers/timarche_mailer
class TimarcheMailerPreview < ActionMailer::Preview
   def welcome_email_preview
   	 Timarche_Mailer.welcome_email(user.first)
   end
end
