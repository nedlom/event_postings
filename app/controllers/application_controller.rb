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
    logged_in_redirect
    erb :welcome
  end

  helpers do
    
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def authorized_access?(user)
      user == current_user
    end

    def logged_in_redirect
      if logged_in?
        flash[:errors] = "You are already logged in."
        redirect "/users/#{current_user.id}"
      end 
    end

    def not_logged_in_redirect
      if !logged_in?
        flash[:errors] = "Please log in or signup."
        redirect '/'
      end
    end

  end

end
