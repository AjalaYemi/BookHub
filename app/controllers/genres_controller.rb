class GenresController < ApplicationController
  def index
    @genres = Genre.all
    @books = Book.all
  end

  def show
    @genre = Genre.find(params[:id])
    # @books = Book.all
  end

  def new
    @genre = Genre.new
    @books = Book.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "New Genre created successfully"
      redirect_to(:action => 'index')
    else
      # Error
      flash[:notice] = "The genre did not save because of some errors"
      render('new')
    end
  end

  def edit
    @genre = Genre.find(params[:id])
    @books = Book.all
  end

  def update
     @genre = Genre.find(params[:id])
    if @genre.update_attributes(genre_params)
      flash[:notice] = "Genre updated successfully"
      redirect_to(:action => 'show', :id => @genre.id)
    else
      # Error
      flash[:notice] = "The genre did not update because of some errors"
      @books = Book.all
      render('edit', :id => @genre.id)
    end
  end

  def delete
    @genre = Genre.find(params[:id])
  end

  def destroy
    genre = Genre.find(params[:id]).destroy
    flash[:notice] = "Congratulations! The genre '#{genre.genre}' deleted successfully"
    redirect_to(:action => 'index')
  end

  

  private

  def genre_params
    params.require(:genre).permit(:genre, :book_id)
  end

 

end
