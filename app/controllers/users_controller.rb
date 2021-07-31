class UsersController < ApplicationController

  get '/signup' do 
    logged_in_redirect
    erb :'/users/signup'
  end

  post '/users' do 
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      flash[:message] = "Welcome #{@user.name}. You have created...."
      redirect "/users/#{@user.id}"
    else
      flash[:errors] = "Account creation failure #{@user.errors.full_messages.to_sentence}"
      redirect 'users/signup'
    end
  end

  get '/login' do 
    logged_in_redirect
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

  get '/users/:id' do 
    not_logged_in_redirect
    @user = User.find_by(id: params[:id])
    if authorized_access?(@user)
      erb :'users/show'
    else 
      flash[:errors] = "You don't have access to that page."
      redirect "/events"
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end
