class UsersController < ApplicationController

    get '/login' do 
        erb :login
    end

    # receive login form, find user, log user in (create session)
    post '/login' do 
    end

    get '/signup' do 
    end

end
