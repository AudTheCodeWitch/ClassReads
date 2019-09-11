class StudentsController < ApplicationController
  get '/students' do
    if logged_in?
      if session[:role] == "teacher"
        @teacher = Teacher.find_by(username: current_user.username)
      else
        @student = Student.find_by(username: current_user.username)
        @teacher = @student.teacher
      end
      @students = @teacher.students.all.sort_by { |s| s.name}

      erb :'student/index'
    else
      redirect '/login'
    end
  end

  get '/students/new' do
    if session[:role] == "teacher"
      erb :'student/new'
    else
      redirect '/students'
    end
  end

  post '/students' do
    @student = Student.create(name: params[:name], username: params[:username], password: params[:password])
    @student.teacher = Teacher.find_by(username: current_user.username)
    @student.save
    redirect '/students'
  end

  get '/students/:username' do
    if logged_in?
      @student = Student.find_by(username: params[:username])
      @teacher = @student.teacher
      erb :'student/show'
    else
      redirect '/login'
    end
  end

  get '/students/:username/edit' do
    @student = Student.find_by(username: params[:username])
    if current_user.username == params[:username] || current_user.username == @student.teacher.username
      @teacher = @student.teacher
      erb :'student/edit'
    else
      redirect "/students/#{@student.username}"
    end
    erb :'student/edit'
  end

  patch '/students/:username' do
    @student = Student.find_by(username: params[:username])
    if current_user.username == params[:username]
      @student.update(name: params[:name], username: params[:username])
      if params[:password] != ''
        @student.update(password: params[:password])
      end
      redirect "/students/#{@student.username}"
    elsif current_user.username == @student.teacher.username
      @student.update(name: params[:name], username: params[:username], teacher: Teacher.find_by_name(params[:teacher]))
      if params[:password] != ''
        @student.update(password: params[:password])
      end
      @student.save
      redirect "/students/#{@student.username}"

    end
    redirect '/students/:username'
  end

  delete '/students/:username' do
    @student = Student.find_by(username: params[:username])
    if current_user.username == @student.teacher.username
      Student.destroy(@student.id)
      redirect '/students'
    else
      redirect '/students/:username'
    end
  end

end
