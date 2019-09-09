class Book < ActiveRecord::Base
  belongs_to :teacher
  has_many :reviews
  has_many :students, through: :reviews
end