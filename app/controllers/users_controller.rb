class UsersController < ApplicationController

  get '/login' do 
    erb :login
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
      redirect '/login' 
    end
  end

  get '/signup' do 
    erb :signup
  end

  post '/users' do 
    @user = User.new(params)

    if @user.save
      session[:user_id] = @user.id
      flash[:message] = "Welcome #{@user.id}. You have created...."
      redirect "/users/#{@user.id}"
    else
      flash[:errors] = "Account creation failure #{@user.errors.full_messages.to_sentence}"
      redirect '/signup'
    end
  end

  get '/users/:id' do 
    @user = User.find_by(id: params[:id])
    erb :'users/show'
  end

  get '/logout' do
    binding.pry
    session.clear
    binding.pry
    redirect '/'
  end

end
