class EventsController < ApplicationController

  get '/events' do 
    if !logged_in
      redirect '/'
    else
      @events = Event.all
      erb :'/events/index'
    end
  end

  get '/events/new' do 
    if !logged_in
      redirect '/'
    else
      erb :'/events/new'
    end
  end

  post '/events' do 
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
    @event = Event.find(params[:id])
    binding.pry
    
    erb :'/events/show'
  end

  get '/events/:id/edit' do 
  
    
    if 
      erb :'/events/edit'
    else
      redirect "/users/#{current_user.id}"
    end
  end

  patch '/events/:id' do
    event = Event.find(params[:id])
    if authorized_access?(@event.user)
      @event.update(
        title: params[:title],
        description: params[:description],
        location: params[:location],
        date: params[:date],
        time: params[:time]
      )
      redirect "/events/#{@event.id}"
    else 
      redirect "/users/#{current_user.id}"
    end
    
  end

  delete '/events/:id' do
    set_event
    if authorized_to_access?(@event.user)
      @event.destroy
      flash[:message] = "Successfully deleted that entry"
      redirect '/events'
    else
      redirect '/events'
    end 
  end

  # private
  # # instance method so @event available to each method in class
  # def set_event
  #   @event = Event.find(params[:id])
  # end

end