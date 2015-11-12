class ReviewsController < ApplicationController

  # before_action :authenticate_user!

  def index
    @reviews = Review.sorted.paginate(page: params[:page], per_page: 10)
  end

  def show
    @review = Review.find_by_url(params[:id])
    @comments = @review.comment_threads.order('created_at desc')
    @new_comment = Comment.build_from(@review, current_user.id, "")
  end

  def new
    @review = Review.new
    @books = Book.all
    @users = User.all
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      flash[:notice] = "New review created successfully"
      redirect_to review_path(@review)
    else
      # Error display and login
      flash[:notice] = "Something went wrong creating the new Review"
      render('new')
    end
  end

  def edit
    @review = Review.find_by_url(params[:id])
    @books = Book.all
    @users = User.all
  end

  def update
    @review = Review.find_by_url(params[:id])
    @review.user_id = current_user.id
    if @review.update_attributes(review_params)
      flash[:notice] = "Review updated successfully"
      redirect_to review_path(@review)
    else
      # Error that the review didn't update
      flash[:notice] = "Something happened and the review didnt save"
      render edit_review_path(@review)
    end
  end

  def delete
    @review = Review.find_by_url(params[:id])
  end

  def destroy
    review = Review.find_by_url(params[:id]).destroy
    flash[:notice] = "The review '#{review.title}' has been successfully deleted"
    redirect_to(:action => 'index')
  end

  private

  def review_params
    params.require(:review).permit(:review, :book_id, :user_id, :title, :url)
  end
end
