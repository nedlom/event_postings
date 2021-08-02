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
    event = current_user.events.build(event_attribute_hash)
    if event.save
      flash[:message] = "Event creation successful."
      redirect "/events/#{event.id}"
    else
      flash[:errors] = "Event creation failed: #{event.errors.full_messages.to_sentence}."
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
    if get_event.update(event_attribute_hash)
      flash[:message] = "Event update successful."
      redirect "/events/#{get_event.id}"
    else 
      flash[:errors] = "Event update failed: #{get_event.errors.full_messages.to_sentence}"
      redirect "/events/#{get_event.id}/edit"
    end
  end

  delete "/events/:id" do
    check_access
    get_event.destroy
    flash[:message] = "Event deletion successful."
    redirect "/events"  
  end

end