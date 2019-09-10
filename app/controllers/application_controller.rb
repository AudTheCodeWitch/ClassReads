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

  post '/login' do
    if params[:username] == "" || params[:name] == "" || params[:password] == ""
      redirect '/register'
    elsif params[:role] == "teacher"
      @user = Teacher.create(name: params[:name], username:params[:username], password: params[:password])
      session[:user_id] = @user.id
      redirect '/students'
    elsif params[:role] == 'student'
      @user = Student.create(name: params[:name], username:params[:username], password: params[:password])
      session[:user_id] = @user.id
      redirect '/reviews'

    end
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
