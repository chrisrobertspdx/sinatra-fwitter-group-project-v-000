class TweetsController < ApplicationController

  get '/tweets' do
    #binding.pry
    if !logged_in?
      redirect to '/login'
    else
      @user = User.find(session[:user_id])
    end
    erb :'/tweets/tweets'
  end

  post '/tweets' do
    #check if logged in
    #create tweet
    @tweet = Tweet.create(params)
    @tweet.user = current_user
    if @tweet.save
      redirect to "/tweets"
    else
      #flash error?
      redirect to "/tweets/new"
    end
    #erb :'/tweets/create_tweet'
  end

  get '/tweets/new' do
    #check login
    if !logged_in?
      redirect to "/login"
    end
    erb :'/tweets/create_tweet'
  end

end
