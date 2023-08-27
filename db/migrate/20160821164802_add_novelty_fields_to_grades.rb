class AddNoveltyFieldsToGrades < ActiveRecord::Migration
  def change
    add_column :grades, :novelty_1_text, :text
    add_column :grades, :novelty_2_text, :text
    add_column :grades, :novelty_3_text, :text
    add_column :grades, :novelty_4_text, :text
    add_column :grades, :novelty_5_text, :text
    add_column :grades, :novelty_1_score, :integer
    add_column :grades, :novelty_2_score, :integer
    add_column :grades, :novelty_3_score, :integer
    add_column :grades, :novelty_4_score, :integer
    add_column :grades, :novelty_5_score, :integer
  end
end
