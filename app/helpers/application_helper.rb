module ApplicationHelper
	def error_messages_for(object)
		render(:partial => 'application/error_messages', :locals => {:object => object})
	end
	def header(text)
  		content_for(:header) { text.to_s }
	end
	def find_user(user_id)
		@user = User.find(user_id)
		@user.name
	end
end
