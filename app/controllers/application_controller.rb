require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "changethissecret"
  end

  get "/" do
    erb :welcome
  end

  get '/login' do
    erb :login
  end

  get '/register' do
    erb :register
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
