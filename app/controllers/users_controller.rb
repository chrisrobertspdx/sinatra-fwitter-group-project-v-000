class UsersController < ApplicationController

  get '/signup' do
    #binding.pry
    if !!session[:user_id]
      redirect to '/tweets'
    end
    erb :'/users/create_user'
  end

  post '/signup' do
    #make sure username is not taken
    #make sure passwords match
    #User.create(params[:user])
    user = User.new(params)
    #binding.pry
    if user.save
      #binding.pry
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      #binding.pry
      #add error message
      redirect to "/signup"
    end

  end

  get '/login' do
    if !!session[:user_id]
      redirect to '/tweets'
    end
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      #need error message
      redirect "/login"
    end

    #params.inspect
  end

  get '/detail' do
    @user = User.find(session[:user_id])
    erb :'users/show'
  end

  get '/failure' do

    erb :'failure'
  end

  get '/logout' do
    if !!session[:user_id]
      session.clear
    end
    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

end
