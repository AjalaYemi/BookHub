class EventsController < ApplicationController


  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :authenticate_admin!, only: [:delete, :destroy]

  def index
    @events = Event.sorted.paginate(page: params[:page], per_page: 8)
    @users = User.all
  end

  def show
    unless current_user == nil
      @event = Event.find_by_url(params[:id])
      @users = User.all
      @comments = @event.comment_threads.order('created_at desc')
      @new_comment = Comment.build_from(@event, current_user.id, "")
    else
      @event = Event.find_by_url(params[:id])
      @users = User.all
      @comments = @event.comment_threads.order('created_at desc')
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.created_by = current_user.id
    if @event.save
      flash[:notice] = "Event created successfully"
      redirect_to events_path
    else
      # Error handling for failure
      flash[:notice] = "Something went wrong while creating the event."
      render('new')
    end
  end

  def edit
    @event = Event.find_by_url(params[:id])
  end

  def update
      @event = Event.find_by_url(params[:id])
      if @event.created_by == current_user.id || current_user.try(:admin?)
        if @event.update_attributes(event_params)
            flash[:notice] = "Event updated successfully"
            redirect_to event_path(@event)
        else
            # Error handling for failure
            flash[:notice] = "Something went wrong while updating the event."
            render edit_event_path(@event)
      end
    else
      flash[:notice] = "You are not authorized to alter this as you are neither the creator nor an admin"
      redirect_to('index')
    end
  end

  def delete
    @event = Event.find_by_url(params[:id])
  end

  def destroy
    event = Event.find_by_url(params[:id]).destroy
    if event.created_by == current_user.id || current_user.try(:admin?)
      flash[:notice] = "The event #{event.name} has been successfully deleted"
      redirect_to(:action => 'index')
    else
      flash[:notice] = "You are not authorized to alter this as you are neither the creator nor an admin"
      redirect_to('index')
    end
  end


   def attend
    @event = Event.find(params[:id])
    @user = User.find(current_user.id)
    if @event.users.include?current_user && @event.users << @user
       flash[:notice] = "You have been registered"
       @users = User.all
       redirect_to event_path(@event)
    else
       flash[:notice] = "Something happened and you were not registered. Try again later"
       @users = User.all
       redirect_to event_path(@event)
    end
  end

  def miss
    @event = Event.find(params[:id])
    @user = User.find(current_user.id)
    if @event.users.include?current_user && @event.users.delete(@user)
       flash[:notice] = "You have been de-registered"
       @users = User.all
       redirect_to event_path(@event)
    else
       flash[:notice] = "Something happened and you were not registered. Try again later"
       @users = User.all
       redirect_to event_path(@event)
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :venue, :city, :no_of_available_seats, :user_id, :description, :avatar, :avatar_cache, :url)
  end
end
