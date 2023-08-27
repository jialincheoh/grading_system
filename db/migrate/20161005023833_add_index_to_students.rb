class AddIndexToStudents < ActiveRecord::Migration
  def change
    add_index :students, :id, unique: true
  end
end
