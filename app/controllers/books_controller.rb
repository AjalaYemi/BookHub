class BooksController < ApplicationController

  def index
    if params[:tag]
      @books = Book.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 10)
    else
      @books = Book.sorted.paginate(page: params[:page], per_page: 10)
    end
  end

  def show
    @book = Book.find_by_url(params[:id])
    @users = User.all
    @comments = @book.comment_threads.order('created_at desc')
    @new_comment = Comment.build_from(@book, current_user.id, "")
  end

  def new
    @book = Book.new
  end

  def create
    # Instantiate a new object using form parameters
    @book = Book.new(book_params)
    @book.created_by = current_user.id
    # Save the object
    if @book.save
    # If save succeeds, redirect to the index action
    flash[:notice] = "Congratulations! New Book Created."
    redirect_to books_path
    else
    # If save fails, redisplay the form so the user can fix the problems
    render('new')
    end
  end

  def edit
    @book = Book.find_by_url(params[:id])
  end

  def update
     # find an existing object using form parameters
    @book = Book.find_by_url(params[:id])
    @book.updated_by = current_user.id
    # Update the object
    if @book.update_attributes(book_params)
    # If update succeeds, redirect to the index action
    flash[:notice] = "Congratulations! Book successfully updated."
    redirect_to book_path(@book)
    else
    # If save fails, redisplay the form so the user can fix the problems
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

  private

  def book_params
    params.require(:book).permit(:name, :publisher,:isbn, :author_id, :bio, :published_year, :word_count, :page_count, :front_avatar, :front_avatar_cache, :url, :tag_list, :genre_list, :author_list)
  end
end
