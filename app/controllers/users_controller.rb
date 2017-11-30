class UsersController < ApplicationController

  get '/users/create' do
    erb :'/users/create_user'
  end

  post '/users/create' do
    #make sure username is not taken
    #make sure passwords match
    #User.create(params[:user])
    user = User.new(params[:user])
    user.password
    user.save

    if user.save
      redirect to "/users/login"
    else
      redirect to "/users/createfailed"
    end

  end

  get '/users/login' do
    erb :'/users/login'
  end

  post '/users/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/detail"
    else
      redirect "/users/failure"
    end

    #params.inspect
  end

  get '/users/detail' do
    @user = User.find(session[:user_id])
    erb :'users/show'
  end

  get '/users/failure' do

    erb :'/users/failure'
  end

end
