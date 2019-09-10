class TeachersController < ApplicationController
  get 'teachers/:username' do
    if logged_in?
      @teacher = Teacher.find_by_id(params[:id])
      erb :'teacher/index'
    else
      redirect '/login'
    end
  end
end