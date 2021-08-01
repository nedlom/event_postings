class EventsController < ApplicationController

  get '/events' do 
    if !logged_in?
      redirect '/'
    else
      @events = Event.all
      erb :'/events/index'
    end
  end

  get '/events/new' do 
    if !logged_in?
      redirect '/'
    else
      erb :'/events/new'
    end
  end

  post '/events' do 
    redirect_if_not_logged_in
    @event = current_user.events.build(params)
    if @event.save
      flash[:message] = "success"
      redirect "/events/#{@event.id}"
    else
      flash[:errors] = "Event creation failed. #{@event.errors.full_messages.to_sentence}."
      redirect '/events/new'
    end
  end

  get '/events/:id' do
    @event = Event.find_by(id: params[:id])  
    if @event
      erb :'/events/show'
    else
      flash[:error] = "There is no event with that id."
      redirect '/events'
    end
  end

  get '/events/:id/edit' do 
    if !logged_in?
      redirect '/'
    end

    @event = Event.find_by(id: params[:id])
    if @event
      erb :'/events/edit'
    else
      redirect "/users/#{current_user.id}"
    end
  end

  patch '/events/:id' do
    event = Event.find_by(id: params[:id])
    
    if event.user != current_user
      flash[:errors] = "You can only edit your own events."
      redirect '/'
    end

   if event.update(params[:event])
      redirect "/events/#{event.id}"
    else 
      flash[:errors] = "Update failed. #{event.errors.full_messages.to_sentence}"
      redirect "/users/#{current_user.id}"
    end
    
  end

  delete '/events/:id' do
    event = Event.find_by(id: params[:id])
    event.destroy
    flash[:message] = "Successfully deleted that entry"
    redirect '/events'  
  end

  # private
  # # instance method so @event available to each method in class
  # def set_event
  #   @event = Event.find(params[:id])
  # end

end