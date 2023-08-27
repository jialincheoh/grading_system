class AddMoreIndexToGrades < ActiveRecord::Migration
  def change
    add_index :grades, :phase
    add_index :grades, [:project_id, :phase]
  end
end
