class EventsController < ApplicationController

  def index
    @events = Event.sorted.paginate(page: params[:page], per_page: 10)
    @users = User.all
  end

  def show
    @event = Event.find_by_url(params[:id])
    @users = User.all
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
    @event = Event.find_by_url(params[:id])
    @user = User.find(current_user.id)
    if @event.users.include?current_user && @event.users << @user
       flash[:notice] = "You have been registered"
       @users = User.all
       redirect_to(:action => 'show', :id => @event.id)
    else
       flash[:notice] = "Something happened and you were not registered. Try again later"
       @users = User.all
       redirect_to(:action => 'show', :id => @event.id)
    end
  end

  def miss
    @event = Event.find_by_url(params[:id])
    @user = User.find(current_user.id)
    if @event.users.include?current_user && @event.users.delete(@user)
       flash[:notice] = "You have been de-registered"
       @users = User.all
       redirect_to(:action => 'show', :id => @event.id)
    else
       flash[:notice] = "Something happened and you were not registered. Try again later"
       @users = User.all
       redirect_to(:action => 'show', :id => @event.id)
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :venue, :city, :no_of_available_seats, :user_id, :description, :avatar, :avatar_cache, :url)
  end
end
