class Teacher < ActiveRecord::Base
  has_secure_password
  has_many :students
  has_many :books

  def total_reviews
    total = 0
    self.students.each do |s|
      total += s.reviews.length
    end
    total
  end
end