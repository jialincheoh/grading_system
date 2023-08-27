class AddMoreNoveltyFieldsToGrades < ActiveRecord::Migration
  def change
    add_column :grades, :novelty_1_design_score, :integer
    add_column :grades, :novelty_2_design_score, :integer
    add_column :grades, :novelty_3_design_score, :integer
    add_column :grades, :novelty_4_design_score, :integer
    add_column :grades, :novelty_5_design_score, :integer
    add_column :grades, :novelty_1_functionality_score, :integer
    add_column :grades, :novelty_2_functionality_score, :integer
    add_column :grades, :novelty_3_functionality_score, :integer
    add_column :grades, :novelty_4_functionality_score, :integer
    add_column :grades, :novelty_5_functionality_score, :integer
  end
end
