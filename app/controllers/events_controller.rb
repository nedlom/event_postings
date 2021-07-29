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
        binding.pry
        erb :'/events/show'
    end

    get '/events/:id/edit' do 
        set_event
        if logged_in?
            if @event.user == current_user
                erb :'/events/edit'
            else
                redirect "/users/#{current_user.id}"
            end
        else
            redirect '/'
        end
    end

    patch '/events/:id' do
        set_event
        if logged_in?
            if @event.user == current_user
                binding.pry
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
        else
            redirect '/'
        end
    end
    

    private
    # instance method so @event available to each method in class
    def set_event
        @event = Event.find(params[:id])
    end

end