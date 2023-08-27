class AddMoreTechnicalFieldsToGrades < ActiveRecord::Migration
  def change
    add_column :grades, :tech_criteria_9, :integer
    add_column :grades, :tech_criteria_10, :integer
    add_column :grades, :tech_criteria_11, :integer
  end
end
