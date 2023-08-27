class AddErrorFieldsToGrades < ActiveRecord::Migration
  def change
    add_column :grades, :major_errors,    :integer, default: 0
    add_column :grades, :moderate_errors, :integer, default: 0
    add_column :grades, :minor_errors,    :integer, default: 0
  end
end
