class EventsController < ApplicationController

  get "/events" do 
    redirect_if_not_logged_in
    @events = Event.all 
    erb :"/events/index"
  end

  get "/events/new" do 
    redirect_if_not_logged_in
    erb :"/events/new"
  end

  post "/events" do
    event = current_user.events.build(attribute_hash)
    if event.save
      flash[:message] = "New event created."
      redirect "/events/#{event.id}"
    else
      flash[:errors] = "Event creation failed. #{event.errors.full_messages.to_sentence}."
      redirect "/events/new"
    end
  end

  get "/events/:id" do
    redirect_if_not_logged_in
    check_event_existence
    get_event
    erb :"/events/show"
  end

  get "/events/:id/edit" do 
    check_access
    get_event
    erb :"/events/edit"
  end

  patch "/events/:id" do
    check_access
    if get_event.update(attribute_hash)
      flash[:message] = "Successfully updated event."
      redirect "/events/#{get_event.id}"
    else 
      flash[:errors] = "Update failed. #{get_event.errors.full_messages.to_sentence.capitalize}"
      redirect "/events/#{get_event.id}/edit"
    end
  end

  delete "/events/:id" do
    check_access
    get_event.destroy
    flash[:message] = "Successfully deleted event."
    redirect "/events"  
  end

end