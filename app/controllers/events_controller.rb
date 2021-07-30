class EventsController < ApplicationController
# get events/new

  get '/events' do 
    @events = Event.all
    erb :'/events/index'
  end


  get '/events/new' do 
    erb :'/events/new'
  end

  # post events
  post '/events' do 
    redirect_if_not_logged_in
    @event = current_user.events.create(params)
    if @event.save
      flash[:message] = "success"
      redirect "/events/#{@event.id}"
    else
      flash[:errors] = "Please fill out all fields to post an event."
      redirect '/events/new'
    end
  end

  # index route

  get '/events' do 
    erb :'/events/index'
  end
  
  # show route
  get '/events/:id' do
    set_event
    erb :'/events/show'
  end

  get '/events/:id/edit' do 
    set_event
    redirect_if_not_logged_in
    if authorized_to_edit?(@event)
      erb :'/events/edit'
    else
      redirect "/users/#{current_user.id}"
    end
  end

  patch '/events/:id' do
    set_event
    redirect_if_not_logged_in
      # need validations
    if @event.user == current_user
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
    if authorized_to_edit(event)
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