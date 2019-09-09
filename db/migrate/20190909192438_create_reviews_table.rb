class CreateReviewsTable < ActiveRecord::Migration
  def change
    create_table(:reviews) do |t|
      t.integer :rating
      t.text :review
    end
  end
end
