class EventsController < ApplicationController

  def index
    @events = Event.sorted
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
    @users = User.all
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = "Event created successfully"
      redirect_to(:action => 'index')
    else
      # Error handling for failure
      flash[:notice] = "Something went wrong while creating the event."
      render('new')
    end
  end

  def edit
    @event = Event.find(params[:id])
    @users = User.all
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:notice] = "Event updated successfully"
      redirect_to(:action => 'show', :id => @event.id)
    else
      # Error handling for failure
      flash[:notice] = "Something went wrong while updating the event."
      @users = User.all
      render('edit' , :id => @event.id)
    end
  end

  def delete
    @event = Event.find(params[:id])
  end

  def destroy
    event = Event.find(params[:id]).destroy
    flash[:notice] = "The event #{event.name} has been successfully deleted"
    redirect_to(:action => 'index')
  end

  private

  def event_params
    params.require(:event).permit(:name, :venue, :city, :no_of_available_seats, :user_id)
  end
end
