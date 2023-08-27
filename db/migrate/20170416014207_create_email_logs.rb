class CreateEmailLogs < ActiveRecord::Migration
  def change
    create_table :email_logs do |t|
      t.integer :hack_id
      t.integer :project_id
      t.integer :student_id
      t.string :student_email
      t.string :phase
      t.datetime :sent_at
    end
  end
end
