class Student < ActiveRecord::Base
  belongs_to :teacher
  has_many :reviews
  has_many :books, through: :reviews
end
