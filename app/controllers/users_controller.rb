class UsersController < ApplicationController

  get '/signup' do 
    if logged_in?
      redirect "/users/#{user.id}"
    end
    erb :'/users/signup'
  end

  post '/signup' do 
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      flash[:message] = "Welcome #{@user.name}. You have created...."
      redirect "/users/#{@user.id}"
    else
      flash[:errors] = "Account creation failure. #{@user.errors.full_messages.to_sentence}."
      redirect '/signup'
    end
  end

  get '/login' do 
    if logged_in?
      redirect "/users/#{current_user.id}"
    end
    erb :'/users/login'
  end

  # receive login form, find user, log user in (create session)
  post '/login' do 
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:message] = "Welcome #{@user.name}!"
      redirect "/users/#{@user.id}"
    else
      flash[:errors] = "Your credentials blah blah"
      redirect :'users/login' 
    end
  end

  get '/logout' do
    session.clear
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
