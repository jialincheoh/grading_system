class AddReadMeUrlToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :read_me_url, :string
  end
end
