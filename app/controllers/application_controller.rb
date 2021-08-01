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
      flash[:message] = "You are already logged in." if logged_in?
      redirect "/events"
    end

    def redirect_if_not_logged_in
        flash[:message] = "Please login." if !logged_in?
        redirect "/"
      end
    end

    def event_edit_authorization
      redirect_if_not_logged_in
      flash[:errors] = "You are not authorized to edit this event." if !event_belongs_to_user?
      redirect "/event/#{current_event}.id"
    end
  end
end