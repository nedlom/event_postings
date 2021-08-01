class UsersController < ApplicationController

  get '/signup' do 
    redirect_if_logged_in
    erb :'/users/signup'
  end

  post '/signup' do 
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      flash[:message] = "Account creation successful. Welcome, #{@user.name}."
      redirect "/events"
    else
      flash[:errors] = "Account creation failed. #{@user.errors.full_messages.to_sentence}."
      redirect '/signup'
    end
  end

  get '/login' do 
    redirect_if_logged_in
    erb :'/users/login'
  end

  post '/login' do 
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:message] = "Welcome #{user.name}!"
      redirect "/events"
    else
      flash[:errors] = "The email or password is incorrect."
      redirect '/login' 
    end
  end

  get '/logout' do
    redirect_if_not_logged_in
    session.clear
    flash[:message] = "You have successfully logged out."
    redirect '/'
  end

  # get '/users/:id' do 
  #   if !logged_in?
  #     redirect "/"
  #   end

  #   @user = User.find_by(id: params[:id])
  #   if @user == current_user
  #     erb :'users/show'
  #   else 
  #     flash[:errors] = "You don't have access to that page."
  #     redirect "/events"
  #   end
  # end
end
