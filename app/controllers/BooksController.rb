class BooksController < ApplicationController
  get '/books' do
    erb :'book/index'
  end

  get '/books/new' do
    erb :'book/new'
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
    erb :'book/edit'
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

