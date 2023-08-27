class AddHackIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :hack_id, :integer
  end
end
