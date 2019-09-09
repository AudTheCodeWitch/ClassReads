class AddIdColumnsToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :book_id, :integer
    add_column :reviews, :student_id, :integer
  end
end
