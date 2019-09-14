class Book < ActiveRecord::Base
  belongs_to :teacher
  has_many :reviews
  has_many :students, through: :reviews

  def slug
    title.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    Book.all.find { |book| book.slug == slug }
  end

  def average
    avg_rating = []
    if self.reviews.empty?
      average = "No ratings yet"
    else
      self.reviews.each { |r| avg_rating << r.rating }
      average = avg_rating.sum / avg_rating.length
    end
    average
  end
end