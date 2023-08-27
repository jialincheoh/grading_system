ActiveAdmin.register Grade do
  permit_params :project_id,
                :grader_id,
                :usability_score,
                :technical_score,
                :phase,
                :tech_criteria_1,
                :tech_criteria_2,
                :tech_criteria_3,
                :tech_criteria_4,
                :tech_criteria_5,
                :tech_criteria_6,
                :tech_criteria_7,
                :tech_criteria_8,
                :tech_criteria_9,
                :tech_criteria_10,
                :tech_criteria_11,
                :non_tech_criteria_1,
                :non_tech_criteria_2,
                :non_tech_criteria_3,
                :non_tech_criteria_4,
                :non_tech_criteria_5,
                :non_tech_criteria_6,
                :non_tech_criteria_7,
                :non_tech_criteria_8,
                :non_tech_criteria_9,
                :non_tech_criteria_10,
                :non_tech_criteria_11,
                :technical,
                :usability,
                :major_errors,
                :moderate_errors,
                :minor_errors,
                :novelty_1_text,
                :novelty_2_text,
                :novelty_3_text,
                :novelty_4_text,
                :novelty_5_text,
                :novelty_1_score,
                :novelty_2_score,
                :novelty_3_score,
                :novelty_4_score,
                :novelty_5_score,
                :novelty_1_design_score,
                :novelty_2_design_score,
                :novelty_3_design_score,
                :novelty_4_design_score,
                :novelty_5_design_score,
                :novelty_1_functionality_score,
                :novelty_2_functionality_score,
                :novelty_3_functionality_score,
                :novelty_4_functionality_score,
                :novelty_5_functionality_score

  index do
    selectable_column
    id_column
    column :project_id
    column :grader_id
    column :usability_score
    column :technical_score
    column :phase
    column :created_at
    column :updated_at
    actions
  end
end
