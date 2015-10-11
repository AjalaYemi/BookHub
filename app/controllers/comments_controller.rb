class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
    @books = Book.sorted
    # @users = User.all
    @events = Event.sorted
  end

  def new
    @comment = Comment.new
    @books = Book.sorted
    @users = User.all
  end

  def create
    @books = Book.sorted
    @events = Event.sorted
    @users = User.all
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:notice] = "Comment created successfully"
      redirect_to(:action => 'index')
    else
      flash[:notice] = "Comment didnt save because of some errors"
      render('new')
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @books = Book.sorted
    @events = Event.sorted
    @users = User.all
  end

  def update
    @books = Book.sorted
    @users = User.all
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(comment_params)
      flash[:notice] = "Comment updated successfully"
      redirect_to(:action => 'show', :id => @comment.id)
    else
      flash[:notice] = "Comment didnt update because of some errors"
      render('new')
    end
  end

  def delete
    @comment = Comment.find(params[:id])
  end

  def destroy
    comment = Comment.find(params[:id]).destroy
    flash[:notice] = "The comment has been successfully deleted"
    redirect_to(:action => 'index')
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :user_id, :book_id, :review_id, :event_id)
  end
end
