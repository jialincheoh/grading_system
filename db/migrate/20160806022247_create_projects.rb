class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :web_url
      t.integer :student_id
      t.integer :grader_id

      t.timestamps null: false
    end
  end
end
