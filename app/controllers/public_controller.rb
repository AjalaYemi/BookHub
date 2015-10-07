class PublicController < ApplicationController
	
	# layout 'public'

	before_action :setup_navigation

  def index
  	@books = Book.sorted
    @authors = Author.sorted
    
  end

  def show
    @book = Book.find(params[:id])
  	# @book = Book.where(:permalink => params[:permalink])
  	# if @book.nil?
  	# 	redirect_to(:action => 'index')
  	# else
  	# 	# display the page content using show.html.erb
  	# end
  end

  def book
    # Code for when the Unsighed-in user clicks on the book button on the home page/Menu
  end

  def book_show
    # Code for when the Unsigned-in user clicks on a book in the book view
    # Should contain codes to be able to show the Reviews and Comments about the book
  end

  def event
    # Code for when the Unsighed-in user clicks on the event button on the home page/menu 
  end

  def event_show
    # Code for when the Unsigned-in user clicks on a event in the event view
    # Should contain codes to be able to show the seats available, no attending, Reviews and Comments about the event
  end

  def book_swap
    # Code for when the Unsighed-in user clicks on the book swap button on the home page/ Menu
  end

  def donate_book
    # Code for when the unsigned user clicks on the book swap button on the home page/ Menu
  end

  

  private

  def setup_navigation
  	@authors = Author.sorted
  	@books = Book.sorted
  end
end
