require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "event_app"
    register Sinatra::Flash
  end

  get "/" do
    erb :welcome
  end

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def get_event
      @event ||= Event.find_by(id: params[:id])
    end

    def check_event_existence
      if !Event.ids.include?(params[:id].to_i)
        flash[:errors] = "Event does not exist."
        redirect "/events"
      end
    end

    def event_belongs_to_user?
      current_user.events.include?(get_event)
    end

    def redirect_if_logged_in
      if logged_in?
        flash[:message] = "You are already logged in." 
        redirect "/events"
      end
    end

    def redirect_if_not_logged_in
      if !logged_in?
        flash[:errors] = "Login or sign up to view website." 
        redirect "/"
      end
    end

    def redirect_if_event_does_not_belong_to_user
      if !event_belongs_to_user?
        flash[:errors] = "You are not authorized to make changes to #{get_event.user.name}'s events." 
        redirect "/events/#{get_event.id}"
      end
    end

    def check_access
      redirect_if_not_logged_in
      check_event_existence
      redirect_if_event_does_not_belong_to_user
    end

    def params_date_fix
      if params[:date] != ""
        date = params[:date].split("-")
        date[1], date[2] = date[2], date[1]
        date.reverse.join("/")
      end
    end

    def params_time_fix
      params[:time1] + ":" + params[:time2] + params[:time3]
    end

    def event_attribute_hash
      {
        title: params[:title],
        description: params[:description], 
        location: params[:location],
        date: params_date_fix,
        time: params_time_fix
      }

    end
  end
end