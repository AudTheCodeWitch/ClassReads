class TeachersController < ApplicationController
  get '/teachers/:username' do
    if logged_in?
      @teacher = Teacher.find_by(username: params[:username])
      erb :'teacher/show'
    else
      redirect '/login'
    end
  end

end