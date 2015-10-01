class BooksController < ApplicationController

   # layout 'admin'
   
   before_action :confirm_logged_in, :except => [:index, :show]
   before_action :find_author

  def index
    @authors = Author.sorted
    if @author
      @books = Book.where(:author_id => params[:author_id]).sorted
    else
      @books = Book.sorted
      @authors = Author.sorted
    end
    
    # @books = @author.books.sorted
    
  end

  def show
    @book = Book.find(params[:id])
    @authors = Author.sorted
  end

  def new
    @book = Book.new
    @authors = Author.sorted
  end

  def create
    # Instantiate a new object using form parameters
    @book = Book.new(book_params)
    # Save the object
    if @book.save
    # If save succeeds, redirect to the index action
    flash[:notice] = "Congratulations! New Book Created."
    redirect_to(:action => 'index')
    else
    # If save fails, redisplay the form so the user can fix the problems
    @authors = Author.sorted
    render('new')
    end 
  end

  def edit
    @book = Book.find(params[:id])
    @authors = Author.sorted
  end

  def update
     # find an existing object using form parameters
    @book = Book.find(params[:id])    
    # Update the object
    if @book.update_attributes(book_params)
    # If update succeeds, redirect to the index action
     flash[:notice] = "Congratulations! Book successfully updated."
    redirect_to(:action => 'show', :id => @book.id)
    else
    # If save fails, redisplay the form so the user can fix the problems
    @authors = Author.sorted
    render('edit', :id => @book.id)
    end 
  end

  def delete
    @book = Book.find(params[:id]) 
  end

  def destroy
    @book = Book.find(params[:id]).destroy   
    flash[:notice] = "Congratulations! The book '#{@book.name}' deleted successfully"
    redirect_to(:action => 'index')
  end

  
  private

  def book_params
    params.require(:book).permit(:name, :publisher,:isbn, :author_id, :published_year, :word_count, :page_count)
  end

  def find_author
    if params[:author_id]
      @author = Author.find(params[:author_id])
    end
  end

end
