class RemoveGraderIdFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :grader_id, :integer
  end
end
