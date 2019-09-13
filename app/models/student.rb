class Student < ActiveRecord::Base
  has_secure_password
  belongs_to :teacher
  has_many :reviews
  has_many :books, through: :reviews

  def published_reviews
    published = []
    self.reviews.each { |r| published << r if r.book_id != nil}
    published
  end
end
