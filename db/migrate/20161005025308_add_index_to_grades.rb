class AddIndexToGrades < ActiveRecord::Migration
  def change
    add_index :grades, :id, unique: true
    add_index :grades, [:usability, :phase]
    add_index :grades, [:technical, :phase]
  end
end
