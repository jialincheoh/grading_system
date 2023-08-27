class AddIndexToProjects < ActiveRecord::Migration
  def change
    add_index :projects, :id, unique: true
  end
end
