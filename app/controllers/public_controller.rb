class PublicController < ApplicationController
	
	layout 'public'

	before_action :setup_navigation

  def index
  	#Introductory text
  end

  def show
  	@book = Book.where(:permalink => params[:permalink])
  	if @book.nil?
  		redirect_to(:action => 'index')
  	else
  		# display the page content using show.html.erb
  	end
  end

  private

  def setup_navigation
  	@authors = Author.sorted
  	@books = Book.sorted
  end
end
