class EventsController < ApplicationController

  def index
    @events = Event.sorted
    @users = User.all
  end

  def show
    @event = Event.find(params[:id])
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
      redirect_to(:action => 'index')
    else
      # Error handling for failure
      flash[:notice] = "Something went wrong while creating the event."
      render('new')
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update    
      @event = Event.find(params[:id])
      if @event.created_by == current_user.id || current_user.try(:admin?)
        if @event.update_attributes(event_params)
            flash[:notice] = "Event updated successfully"
            redirect_to(:action => 'show', :id => @event.id)
        else
            # Error handling for failure
            flash[:notice] = "Something went wrong while updating the event."           
            render('edit' , :id => @event.id)
      end
    else
      flash[:notice] = "You are not authorized to alter this as you are neither the creator nor an admin"
      redirect_to('index')
    end  
  end

  def delete
    @event = Event.find(params[:id])
  end

  def destroy
    event = Event.find(params[:id]).destroy
    if event.created_by == current_user.id || current_user.try(:admin?)      
      flash[:notice] = "The event #{event.name} has been successfully deleted"
      redirect_to(:action => 'index')
    else
      flash[:notice] = "You are not authorized to alter this as you are neither the creator nor an admin"
      redirect_to('index')
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :venue, :city, :no_of_available_seats, :user_id, :description)
  end
end
