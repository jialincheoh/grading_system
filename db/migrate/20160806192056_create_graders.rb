class CreateGraders < ActiveRecord::Migration
  def change
    create_table :graders do |t|
      t.string :name
      t.string :email
      t.string :grader_type

      t.timestamps null: false
    end
  end
end
