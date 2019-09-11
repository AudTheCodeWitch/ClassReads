class StudentsController < ApplicationController
  get '/students' do
    @students = Student.all
    erb :'student/index'
  end

  get '/students/new' do
    erb :'student/new'
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
      redirect '/students/:username'
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
      redirect "/students/#{student.username}"

    end
    redirect '/students/:username'
  end

  delete '/students/:username' do
    @student = Student.find_by(username: params[:username])
    @stuent.delete
    redirect '/students'
  end

end
