class AuthorsController < ApplicationController
  # layout false


  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @authors = Author.sorted.paginate(page: params[:page], per_page: 10)
  end

  def show
    @author = Author.find(params[:id])
  end

  def new
   @author = Author.new
  end

  def create
     @author = Author.new(author_params)
    if @author.save
      flash[:notice] = "Author created successfully"
      redirect_to(:action => 'index')
    else
      render('new')
    end
  end

  def edit
    @author = Author.find(params[:id])
  end

  def update
    @author = Author.find(params[:id])
    if @author.update_attributes(author_params)
      flash[:notice] = "Author Updated successfully"
      redirect_to(:action => 'show', :id => @author.id)
    else
      render 'edit'
    end
  end

  def delete
     @author = Author.find(params[:id])
  end

  def destroy
    @author = Author.find(params[:id]).destroy
    flash[:notice] = "The author '#{@author.first_name} #{@author.last_name}' has been successfully deleted"
    redirect_to(:action => 'index')
  end

  private
  def author_params
    params.require(:author).permit(:first_name, :last_name, :bio, :avatar, :avatar_cache)
  end
end
