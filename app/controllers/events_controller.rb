class EventsController < ApplicationController

  get '/events' do 
    redirect_if_not_logged_in
    @events = Event.all 
    erb :'/events/index'
  end

  get '/events/new' do 
    redirect_if_not_logged_in
    erb :'/events/new'
  end

  post '/events' do
    @event = current_user.events.build(attribute_hash)
    if @event.save
      flash[:message] = "New Event Created"
      redirect "/events/#{@event.id}"
    else
      flash[:errors] = "Event creation failed. #{@event.errors.full_messages.to_sentence}."
      redirect '/events/new'
    end
  end

  get '/events/:id' do
    redirect_if_not_logged_in
    current_event
    erb :'/events/show'
  end

  get '/events/:id/edit' do 
    check_access
    current_event
    erb :'/events/edit' 
  end

  patch '/events/:id' do
    check_access
    event = Event.find_by(id: params[:id])
    if event.update(attribute_hash)
      redirect "/events/#{event.id}"
    else 
      flash[:errors] = "Update Failed. #{event.errors.full_messages.to_sentence.capitalize}"
      redirect "/events/#{event.id}/edit"
    end
  end

  delete '/events/:id' do
    check_access
    event = Event.find_by(id: params[:id])
    event.destroy
    flash[:message] = "Successfully Deleted Event"
    redirect '/events'  
  end

end