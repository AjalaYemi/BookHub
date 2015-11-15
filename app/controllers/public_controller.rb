class PublicController < ApplicationController

  before_action :authenticate_user!, only: [:make_me_admin]

	def index
    @books = Book.newest_first.four_only
    @events = Event.newest_first.four_only
    @users = User.all
  end

  def show
    @books = Book.newest_first.four_only
    @events = Event.newest_first.four_only
  end

  def make_me_admin
    if current_user.admin?
      flash[:notice]  = "Why are you here again? You are already an admin!"
      #redirect_to(authenticated_root_path)
    else
      current_user.update_attribute :admin, true
    end
    redirect_to(authenticated_root_path)
  end
end
