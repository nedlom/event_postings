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
        set_event
        erb :'/events/show'
    end

    get '/events/:id/edit' do 
        set_event
        erb :'/events/edit'
    end

    patch '/events/:id' do
        set_event
        @entry.update(params)
        redirect "/events/#{@entry.id}"
    end
    

    private
    # instance method so @event available to each method in class
    def set_event
        @event = Event.find(params[:id])
    end

end