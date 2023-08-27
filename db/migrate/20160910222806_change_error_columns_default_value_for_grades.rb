class ChangeErrorColumnsDefaultValueForGrades < ActiveRecord::Migration
  def change
    change_column_default :grades, :major_errors, nil
    change_column_default :grades, :moderate_errors, nil
    change_column_default :grades, :minor_errors, nil
  end
end
