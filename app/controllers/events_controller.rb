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
    current_event
    erb :'/events/show'
    # @event = Event.find_by(id: params[:id])  
    # if @event
    #   erb :'/events/show'
    # else
    #   flash[:errors] = "."
    #   redirect '/events'
    # end
  end

  get '/events/:id/edit' do 
    check_edit_privledges
    current_event
    erb :'/events/edit' 
  end

  patch '/events/:id' do
    check_edit_privledges

    event = Event.find_by(id: params[:id])

   if event.update(params[:event])
      redirect "/events/#{event.id}"
    else 
      flash[:errors] = "Update failed. #{event.errors.full_messages.to_sentence}"
      redirect "/events/#{event.id}/edit"
    end
    
  end

  delete '/events/:id' do
    check_edit_privledges
    event = Event.find_by(id: params[:id])
    event.destroy
    flash[:message] = "Successfully deleted that entry"
    redirect '/events'  
  end

end