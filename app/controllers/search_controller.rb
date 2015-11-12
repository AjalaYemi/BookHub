class SearchController < ApplicationController

  def index
    if params[:q].nil?
     @books = []
     @events = []
     @reviews =[]
    else
     q = params[:q]
     @books    = Book.search(name_cont: q).result
     @events   = Event.search(name_cont: q).result
     @reviews  = Review.search(title_cont: q).result
    end
  end

  def search
    if params[:q].nil?
     @books = []
     @events = []
     @reviews =[]
    else
     q = params[:q]
     @books    = Book.search(name_cont: q).result
     @events   = Event.search(name_cont: q).result
     @reviews  = Review.search(title_cont: q).result
    end
  end
end
