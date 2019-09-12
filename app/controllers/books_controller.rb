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
      @book = Book.find_by_slug(params[:slug])
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
    @book = Book.find_by_slug(params[:slug])
    @book.update(params[:book])
    redirect "/books/#{@book.slug}"
  end

  delete '/books/:slug' do
    @book = Book.find_by_slug(params[:slug])
    @book.delete
    redirect '/books'
  end

  get '/books/:slug/reviews/new' do
    @book = Book.find_by_slug(params[:slug])
    if session[:role] == "student"
      erb :'book/review/new'
    else
      redirect "/books/#{@book.slug}"
    end
  end

  post '/books/:slug/reviews' do
    @book = Book.find_by_slug(params[:slug])
    @review = Review.create(rating: params[:review][:rating], review: params[:review][:review])
    @review.student = Student.find_by(username: current_user.username)
    @review.book = Book.find_by_slug(params[:slug])
    @review.save
    redirect "/books/#{@book.slug}"
  end

  get '/books/:slug/reviews/:id/edit' do
    @book = Book.find_by_slug(params[:slug])
    @review = @book.reviews.find_by_id(params[:id])
    if current_user.username == @review.student.username || session[:role] == 'teacher'
      erb :'book/review/edit'
    else
      redirect "/books/#{@book.slug}"
    end
  end

  patch '/books/:slug/reviews/:id' do
    @book = Book.find_by_slug(params[:slug])
    @review = @book.reviews.find_by_id(params[:id])
    @student = @review.student
    @review.update(params[:review])
    redirect "/books/#{@book.slug}"
  end

  delete '/books/:slug/reviews/:id' do
    @book = Book.find_by_slug(params[:slug])
    @review = @book.reviews.find_by_id(params[:id])
    @student = @review.student
    if student_user?(@student) || session[:role] == 'teacher'
      Review.destroy(@review.id)
      redirect '/books'
    else
      redirect "/books/#{@book.slug}"
    end
  end

end

