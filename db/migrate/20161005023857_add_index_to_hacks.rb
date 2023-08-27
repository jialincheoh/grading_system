class AddIndexToHacks < ActiveRecord::Migration
  def change
    add_index :hacks, :id, unique: true
  end
end
