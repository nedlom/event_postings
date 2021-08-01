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
    redirect_if_logged_in
    erb :welcome
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def current_event
      @current_event ||= Event.find_by(id: params[:id])
    end

    def event_belongs_to_user?
      current_user.events.include?(current_event)
    end

    def redirect_if_logged_in
      if logged_in?
        flash[:message] = "You are already logged in." 
        redirect "/events"
      end
    end

    def redirect_if_not_logged_in
      if !logged_in?
        flash[:message] = "Please login." 
        redirect "/"
      end
    end

    def redirect_if_not_users_event_or_not_logged_in
      redirect_if_not_logged_in
      if !event_belongs_to_user?
        flash[:errors] = "You are not authorized to make changes to #{current_event.user.name}'s event." 
        redirect "/events/#{current_event.id}"
      end
    end

    def params_date_fix
      if params[:event]
        date = params[:event][:date].split("-")
        date[1], date[2] = date[2], date[1]
        params[:event][:date] = date.reverse.join("/")
      else
        date = params[:date].split("-")
        date[1], date[2] = date[2], date[1]
        params[:date] = date.reverse.join("/")
      end
    end

    def params_time_fix
      time = params[:time1] + ":" + params[:time2] + params[:time3]
      if params[:event]
        params[:event][:time] = time
      else
        params[:time] = time
      end
      params.delete(:time1)
      params.delete(:time2)
      params.delete(:time3)
    end

    def format_date_and_time
      params_date_fix
      params_time_fix
    end
  end
end