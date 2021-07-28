class EventsController < ApplicationController
    # get events/new

    get '/events/new' do 
        erb :'/events/new'
    end

    # post events

    post '/events' do 
        if !logged_in?
            redirect '/'
        end

        if params[:title] != ""
            #create new entry
            @event = current_user.events.create(params)
            redirect "/events/#{@event.id}"
        else
            redirect '/events/new'
        end
    end

    # index route

    get '/events' do 
        erb :'/events/index'
    end
    
    # show route
    get '/events/:id' do
        @event = Event.find(params[:id])
        erb :'/events/show'
    end

    get '/events/:id/edit' do 
        erb :'/events/edit'
    end


end