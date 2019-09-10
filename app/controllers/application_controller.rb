require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'changethissecret'
  end

  get '/' do
    erb :welcome
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    if params[:role] == 'teacher'
      @teacher = Teacher.find_by(username: params[:username])
      if @teacher && @teacher.authenticate(params[:password])
        session[:user_id] = @teacher.id
        redirect "/teachers/#{params[:username]}"

      else
        redirect '/register'
      end

    else
      @student = Student.find_by(username: params[:username])
      if @student && @student.authenticate(params[:password])
        session[:user_id] = @student.id
        redirect "/students/#{params[:username]}"

      else
        redirect '/register'
      end
    end
  end



  get '/register' do
    erb :register
  end

  post '/register' do
    if params[:username] == '' || params[:name] == '' || params[:password] == ''
      redirect '/register'

    elsif params[:role] == 'teacher'
      @teacher = Teacher.create(name: params[:name], username: params[:username], password: params[:password])
      session[:user_id] = @teacher.id
      redirect "/teachers/#{params[:username]}"

    elsif params[:role] == 'student'
      @student = Student.create(name: params[:name], username: params[:username], password: params[:password])
      @student.teacher = Teacher.find_by_name(params[:my_teacher])
      @student.save
      session[:user_id] = @student.id
      redirect "/students/#{params[:username]}"

    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end
    #
    # def current_user
    #   User.find(session[:user_id])
    # end
  end

end
