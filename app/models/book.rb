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
end