class AddMoreColumnsToGrades < ActiveRecord::Migration
  def change
    add_column :grades, :technical, :boolean, :default => false
    add_column :grades, :usability, :boolean, :default => false
  end
end
