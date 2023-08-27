class CreateHacks < ActiveRecord::Migration
  def change
    create_table :hacks do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
