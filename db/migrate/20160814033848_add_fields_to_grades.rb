class AddFieldsToGrades < ActiveRecord::Migration
  def change
    add_column :grades, :tech_criteria_1, :integer
    add_column :grades, :tech_criteria_2, :integer
    add_column :grades, :tech_criteria_3, :integer
    add_column :grades, :tech_criteria_4, :integer
    add_column :grades, :tech_criteria_5, :integer
    add_column :grades, :tech_criteria_6, :integer
    add_column :grades, :tech_criteria_7, :integer
    add_column :grades, :tech_criteria_8, :integer
  end
end
