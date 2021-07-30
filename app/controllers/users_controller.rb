class UsersController < ApplicationController

  get '/signup' do 
    redirect_if_logged_in
    erb :'/users/signup'
  end

  post '/users' do 
    binding.pry
    @user = User.new(params)

    if @user.save
      session[:user_id] = @user.id
      flash[:message] = "Welcome #{@user.id}. You have created...."
      redirect "/users/#{@user.id}"
    else
      flash[:errors] = "Account creation failure #{@user.errors.full_messages.to_sentence}"
      redirect 'users/signup'
    end
  end

  get '/login' do 
    redirect_if_logged_in
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
    redirect_if_not_logged_in
    @user = User.find_by(id: params[:id])
    if @user == current_user
      erb :'users/show'
    else 
      flash[:errors] = "You don't have permission to access that page."
      redirect "/events"
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end
