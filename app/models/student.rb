class Student < ActiveRecord::Base
  has_secure_password
  belongs_to :teacher
  has_many :reviews
  has_many :books, through: :reviews
end
