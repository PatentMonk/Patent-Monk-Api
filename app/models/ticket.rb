class Ticket < ActiveRecord::Base
	belongs_to :user

	after_commit :support_ticket, :on => :create

	private
	def support_ticket
    member_id = [ Trello::Member.find('jordanrushing1').id ]
      user = self.user_id ? self.user_id : "Not Signed In"
		if self.request_type == "HELP!"
			trello = Trello::Card.create(name: "Mood: #{self.mood} User Id: #{user}",
				desc: "Message: #{self.msg}", 
				card_labels: [:red], list_id: "545d5a4b200d75562b8b2f35", member_ids: member_id)
		elsif self.request_type == "Feature Request"
			trello = Trello::Card.create(name: "Mood: #{self.mood} User Id: #{user}",
				desc: "Message: #{self.msg}", 
				card_labels: [:green], list_id: "545e330fcbb4c1cfc86de71c", member_ids: member_id)
		else
			trello = Trello::Card.create(name: "Mood: #{self.mood} User Id: #{user}",
				desc: "Message: #{self.msg}", 
				card_labels: [:orange], list_id: "545e3629f280161a1156334b", member_ids: member_id)
		end

	  Email.support_ticket(self,self.user_id ? User.find(self.user_id) : nil, trello.url).deliver
	end
end
