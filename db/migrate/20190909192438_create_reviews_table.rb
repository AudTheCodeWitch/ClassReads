class CreateReviewsTable < ActiveRecord::Migration
  def change
    create_table(:reviews) do |t|
      t.integer :rating
      t.text :review
      t.integer :student_id
      t.integer :book_id
    end
  end
end
