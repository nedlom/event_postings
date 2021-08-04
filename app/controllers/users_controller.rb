class UsersController < ApplicationController

  get "/signup" do 
    redirect_if_logged_in
    erb :"/users/signup"
  end

  post "/signup" do 
    user = User.new(params)
    if user.save
      session[:user_id] = user.id
      flash[:message] = "Account creation successful. Welcome, #{user.name}."
      redirect "/events"
    else
      flash[:errors] = "Account creation failed: #{user.errors.full_messages.to_sentence.capitalize}."
      redirect "/signup"
    end
  end

  get "/login" do 
    redirect_if_logged_in
    erb :"/users/login"
  end

  post "/login" do 
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:message] = "Login successful. Welcome, #{user.name}."
      redirect "/events"
    else
      flash[:errors] = "Incorrect email or password."
      redirect "/login" 
    end
  end

  get "/logout" do
    redirect_if_not_logged_in
    session.clear
    flash[:message] = "Logout successful. Goodbye, #{current_user.name}."
    redirect "/"
  end
  
end
