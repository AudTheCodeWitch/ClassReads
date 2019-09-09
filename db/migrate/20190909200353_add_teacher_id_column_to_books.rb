class AddTeacherIdColumnToBooks < ActiveRecord::Migration
  def change
    add_column :books, :teacher_id, :integer
  end
end
