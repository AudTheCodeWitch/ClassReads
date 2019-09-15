class BooksController < ApplicationController
  get '/books' do
    if logged_in?
      assign_teacher
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

  get '/books/:id/:slug' do
    if logged_in?
      @book = Book.find_by_id(params[:id])
      erb :'book/show'
    else
      redirect '/login'
    end
  end

  get '/books/:id/:slug/edit' do
    @book = Book.find_by_id(params[:id])
    if current_user.username == @book.teacher.username
      @teacher = @book.teacher
      erb :'book/edit'
    else
      redirect "/books/#{@book.id}/#{@book.slug}"
    end
  end

  patch '/books/:id/:slug' do
    @book = Book.find_by_id(params[:id])
    @book.update(params[:book])
    redirect "/books/#{@book.id}/#{@book.slug}"
  end

  delete '/books/:id/:slug' do
    @book = Book.find_by_id(params[:id])
    @book.reviews.each {|r| r.destroy}
    @book.save
    @book.destroy
    redirect '/books'
  end

  get '/books/:id/:slug/reviews/new' do
    @book = Book.find_by_id(params[:id])
    if session[:role] == "student"
      erb :'book/review/new'
    else
      redirect "/books/#{@book.id}/#{@book.slug}"
    end
  end

  post '/books/:id/:slug/reviews' do
    @book = Book.find_by_id(params[:id])
    @review = Review.create(rating: params[:review][:rating], review: params[:review][:review])
    @review.student = Student.find_by(username: current_user.username)
    @review.book = Book.find_by_id(params[:id])
    @review.save
    redirect "/books/#{@book.id}/#{@book.slug}"
  end

  get '/books/:id/:slug/reviews/:review_id/edit' do
    @book = Book.find_by_id(params[:id])
    @review = @book.reviews.find_by_id(params[:review_id])
    if current_user.username == @review.student.username || session[:role] == 'teacher'
      erb :'book/review/edit'
    else
      redirect "/books/#{@book.id}/#{@book.slug}"
    end
  end

  patch '/books/:id/:slug/reviews/:review_id' do
    @book = Book.find_by_id(params[:id])
    @review = @book.reviews.find_by_id(params[:review_id])
    @student = @review.student
    @review.update(params[:review])
    redirect "/books/#{@book.id}/#{@book.slug}"
  end

  delete '/books/:id/:slug/reviews/:review_id' do
    @book = Book.find_by_id(params[:id])
    @review = @book.reviews.find_by_id(params[:review_id])
    @student = @review.student
    if student_user?(@student) || session[:role] == 'teacher'
      Review.destroy(@review.id)
      redirect '/books'
    else
      redirect "/books/#{@book.id}/#{@book.slug}"
    end
  end

end

