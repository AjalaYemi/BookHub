class PublicController < ApplicationController

  before_action :authenticate_user!, only: [:make_me_admin]
	
	def index
  end

  def show
  end

  def make_me_admin
    if current_user.admin?
      # Why are you here again? You are already an admin!
      # 
    else
      current_user.update_attribute :admin, true
    end  
    redirect_to(authenticated_root_path) 
  end

end
