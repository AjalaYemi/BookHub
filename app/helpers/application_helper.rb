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

	def nav_link(link_text, link_path, http_method=nil)
    class_name = current_page?(link_path) ? 'active' : ''

    content_tag(:li, class: class_name) do
      if http_method
        link_to(link_text, link_path, method: http_method)
      else
        link_to(link_text, link_path)
      end
    end
  end

end
