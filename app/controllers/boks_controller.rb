class BooksController < ApplicationController
  get '/books' do
    if logged_in?
      if session[:role] == "teacher"
        @teacher = Teacher.find_by(username: current_user.username)
      else
        @student = Student.find_by(username: current_user.username)
        @teacher = @student.teacher
      end
      @books = @teacher.books.all.sort_by { |b| b.author}

      erb :'book/index'
    else
      redirect '/login'
    end
    erb :'book/index'
  end

  get '/books/new' do
    if session[:role] == "teacher"
      erb :'book/new'
    else
      redirect '/books'
    end
  end

  post '/books' do
    @book = Book.create(title: params[:title], author: params[:author], genre: params[:genre])
    @book.teacher = Teacher.find_by(username: current_user.username)
    @book.save
    redirect '/books'
  end

  get '/books/:slug' do
    if logged_in?
      @book = Book.find_by(title: params[:title])
      erb :'book/show'
    else
      redirect '/login'
    end
  end

  get '/books/:slug/edit' do
    @book = Book.find_by_slug(params[:slug])
    if current_user.username == @book.teacher.username
      @teacher = @book.teacher
      erb :'book/edit'
    else
      redirect "/books/#{@book.slug}"
    end
  end

  patch '/books/:slug' do
    redirect '/books/:slug'
  end

  delete '/books/:slug' do
    @book = Book.find_by(title: params[:title])
    @book.delete
    redirect '/books'
  end

end

