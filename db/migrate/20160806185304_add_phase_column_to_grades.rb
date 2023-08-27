class AddPhaseColumnToGrades < ActiveRecord::Migration
  def change
    add_column :grades, :phase, :string
  end
end
