class StudentsController < ApplicationController
  get '/students/:username' do
    if logged_in?
      @student = Student.find_by(username: params[:username])
      erb :'student/show'
    else
      redirect '/login'
    end
  end
end
