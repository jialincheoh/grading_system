class AddHackNameToGraders < ActiveRecord::Migration
  def change
    add_column :graders, :hack_name, :string
  end
end
