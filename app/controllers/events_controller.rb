class EventsController < ApplicationController
# get events/new

  get '/events' do 
    not_logged_in_redirect
    @events = Event.all
    erb :'/events/index'
  end


  get '/events/new' do 
    not_logged_in_redirect
    erb :'/events/new'
  end

  post '/events' do 
    # redirect_if_not_logged_in
    @event = current_user.events.create(params)
    if @event.save
      flash[:message] = "success"
      redirect "/events/#{@event.id}"
    else
      flash[:errors] = "Please fill out all fields to post an event."
      redirect '/events/new'
    end
  end

  get '/events/:id' do
    not_logged_in_redirect
    set_event
    erb :'/events/show'
  end

  get '/events/:id/edit' do 
    set_event
    not_logged_in_redirect
    if authorized_to_access?(@event.user)
      erb :'/events/edit'
    else
      redirect "/users/#{current_user.id}"
    end
  end

  patch '/events/:id' do
    set_event
    if authorized_to_access?(@event.user)
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

  private
  # instance method so @event available to each method in class
  def set_event
    @event = Event.find(params[:id])
  end

end