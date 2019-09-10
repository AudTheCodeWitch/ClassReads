class ChangeTeacherPasswordToPasswordDigest < ActiveRecord::Migration
  def change
    rename_column :teachers, :password, :password_digest
  end
end
