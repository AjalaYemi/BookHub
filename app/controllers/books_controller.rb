class BooksController < ApplicationController


  # before_action :confirm_logged_in, :except => [:index, :show]
   before_action :find_author

  def index
    @authors = Author.sorted
    if @author
      @books = Book.where(:author_id => params[:author_id]).sorted
    else
      @books = Book.sorted.paginate(page: params[:page], per_page: 10)
      @authors = Author.sorted
    end

  end

  def show
    @book = Book.find_by_url(params[:id])
    @authors = Author.sorted
    @users = User.all
  end

  def new
    @book = Book.new
    @authors = Author.sorted
  end

  def create
    # Instantiate a new object using form parameters
    @book = Book.new(book_params)
    @book.created_by = current_user.id
    # author = Author.find(params[:author_id])
    # Save the object
    if @book.save
    # If save succeeds, redirect to the index action
    # @book.authors << author
    flash[:notice] = "Congratulations! New Book Created."
    redirect_to books_path
    else
    # If save fails, redisplay the form so the user can fix the problems
    @authors = Author.sorted
    render('new')
    end
  end

  def edit
    @book = Book.find_by_url(params[:id])
    @authors = Author.sorted
  end

  def update
     # find an existing object using form parameters
    @book = Book.find_by_url(params[:id])
    @book.updated_by = current_user.id
    # author = Author.find(params[:author_id])
    # Update the object
    if @book.update_attributes(book_params)
    # If update succeeds, redirect to the index action
    # @book.authors << author
    flash[:notice] = "Congratulations! Book successfully updated."
    redirect_to book_path(@book)
    else
    # If save fails, redisplay the form so the user can fix the problems
    @authors = Author.sorted
    render edit_book_path(@book)
    end
  end

  def delete
    @book = Book.find_by_url(params[:id])
  end

  def destroy
      @book = Book.find_by_url(params[:id]).destroy
      flash[:notice] = "Congratulations! The book '#{@book.name}' deleted successfully"
      redirect_to(:action => 'index')
  end

  def find_author
    if params[:author_id]
      @author = Author.find(params[:author_id])
    end
  end

  private

  def book_params
    params.require(:book).permit(:name, :publisher,:isbn, :author_id, :bio, :published_year, :word_count, :page_count, :front_avatar, :front_avatar_cache, :url)
  end
end
