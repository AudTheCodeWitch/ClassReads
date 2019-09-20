class AddProfileToStudents < ActiveRecord::Migration
  def change
    add_column :students, :profile, :text
  end
end
