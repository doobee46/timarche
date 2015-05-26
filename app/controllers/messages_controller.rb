class MessagesController < ApplicationController
	# GET /message/new
  
  def new
    @chosen_recipient = User.find_by(id: params[:to].to_i) if params[:to]
  end
  
 
   # POST /message/create
   def create
    recipients = User.where(id: params['recipients'])
    conversation = current_user.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
    #current_user.create_activity(@recipients, "send")  
    flash[:success] = "Message has been sent!"
    redirect_to conversation_path(conversation)
  end

  
end
