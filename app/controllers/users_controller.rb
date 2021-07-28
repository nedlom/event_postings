class UsersController < ApplicationController

    get '/login' do 
        erb :login
    end

    # receive login form, find user, log user in (create session)
    post '/login' do 
        @user = User.find_by(email: params[:email])

        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
        else
        end
    end

    get '/signup' do 
        erb :signup
    end

    post '/users' do 
        if !params[:name].empty? && !params[:email].empty && !params[:password].empty? # won't save w/o password
            @user = User.create(params)
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
        else
            redirect '/signup'
        end
    end

    get '/users/:id' do 
        @user = User.find_by(id: params[:id])
        erb :'users/show'
    end

    get '/logout' do
        session.clear
        redirect '/'
    end

end
