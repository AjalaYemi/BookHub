class ReviewsController < ApplicationController
  def index
    @reviews = Review.sorted
    # @users = User.all
    # @books = Book.all
    @authors = Author.sorted
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
    @books = Book.all
    @users = User.all
  end

  def create    
    @review = Review.new(review_params)
    if @review.save
      flash[:notice] = "New review created successfully"
      redirect_to(:action => 'index')
    else
      # Error display and login
      flash[:notice] = "Something went wrong creating the new Review"
      render('new')
    end
  end

  def edit
    @review = Review.find(params[:id])
    @books = Book.all
    @users = User.all
  end

  def update
    @review = Review.find(params[:id])
    if @review.update_attributes(review_params)
      flash[:notice] = "Review updated successfully"
      redirect_to(:action => 'show', :id => @review.id)
    else
      # Error that the review didn't update
      flash[:notice] = "Something happened and the review didnt save"
      render('edit', :id => @review.id)
    end
  end

  def delete
    @review = Review.find(params[:id])
  end

  def destroy
    review = Review.find(params[:id]).destroy
    flash[:notice] = "The review '#{review.title}' has been successfully deleted"
    redirect_to(:action => 'index')
  end

  private

  def review_params
    params.require(:review).permit(:review, :book_id, :user_id, :title)
  end
end
