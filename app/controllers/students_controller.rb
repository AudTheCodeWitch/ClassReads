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
    erb :'student/edit'
  end

  patch '/students/:username' do
    redirect '/students/:username'
  end

  delete '/students/:username' do
    @student = Student.find_by(username: params[:username])
    @stuent.delete
    redirect '/students'
  end

end
