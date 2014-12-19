class PusherSend < ActiveRecord::Base
  def self.new_message(receiver_id,sender_id,conversation_id,message)
    Pusher.trigger("private-new_message-#{receiver_id}", 'new_message', 
    	{message: message, sender_id: sender_id,conversation_id: conversation_id}
    )
  end

  def self.new_patent(receiver_id,sender_id,conversation_id,message)
  	# When Lawyer accepts
    Pusher.trigger("private-new_patent-#{receiver_id}", 'new_patent', 
    	{message: message, sender_id: sender_id,conversation_id: conversation_id})
  end

  def self.new_hire(receiver_id,sender_id,conversation_id,message)
  	# When user wants to hire lawyer
    Pusher.trigger("private-new_hire-#{receiver_id}", 'new_hire', 
    	{message: message, sender_id: sender_id,conversation_id: conversation_id}
    )
  end
end