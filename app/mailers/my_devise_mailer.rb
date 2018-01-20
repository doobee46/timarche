class MyDeviseMailer < Devise::Mailer

  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  def confirmation_instructions(record, token, opts={})
    attachments.inline["mailer_bg.png"] = File.read(Rails.root.join('app/assets/images/mailer_bg.png'))
    attachments.inline["mailer_footer_bg.png"] = File.read(Rails.root.join('app/assets/images/mailer_footer_bg.png'))
    super
  end
    
  def reset_password_instructions(record, token, opts={})
    attachments.inline["mailer_bg.png"] = File.read(Rails.root.join('app/assets/images/mailer_bg.png'))
    attachments.inline["mailer_footer_bg.png"] = File.read(Rails.root.join('app/assets/images/mailer_footer_bg.png'))
    super
  end

end