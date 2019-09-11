class TeachersController < ApplicationController
  get '/teachers/:username' do
    if logged_in?
      @teacher = Teacher.find_by(username: params[:username])
      erb :'teacher/show'
    else
      redirect '/login'
    end
  end

  get'/teachers/:username/edit' do
    if current_user.username == params[:username]
      @teacher = Teacher.find_by(username: params[:username])
      erb :'teacher/edit'
    else
      redirect '/teachers/:username'
    end
  end

  patch '/teachers/:username' do

  end

  get '/teachers/:username/delete' do
    if current_user.username == params[:username]
      @teacher = Teacher.find_by(username: params[:username])
      erb :'teacher/delete'
    else
      redirect '/teachers/:username'
    end
  end

  delete '/teachers/:username' do
    if current_user.username == params[:username]
      @teacher = Teacher.find_by(username: params[:username])
      Teacher.destroy(@teacher.id)
      session.destroy
      redirect '/'
    else
      redirect '/teachers/:username'
    end
  end


end