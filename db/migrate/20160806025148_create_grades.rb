class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.integer :project_id
      t.integer :grader_id
      t.integer :usability_score
      t.integer :technical_score

      t.timestamps null: false
    end
  end
end
