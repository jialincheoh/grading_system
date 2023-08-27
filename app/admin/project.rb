ActiveAdmin.register Project do
  permit_params :name, :web_url, :student_id, :read_me_url, :hack_id

  filter :name
  filter :read_me_url
  filter :web_url

  index do
    column :id
    column :name
    column :web_url
    column :student_id
    column :read_me_url
    column :hack_id
    column 'Tech Judge' do |project|
      project.technical_grader
    end
    column 'UX Judge' do |project|
      project.usability_grader
    end
    actions
  end

  show do |project|
    attributes_table_for project do
      row :id
      row :name
      row :web_url
      row :student_id
      row :read_me_url
      row :hack_id
      row 'Tech Judge' do |project|
        project.technical_grader
      end
      row 'UX Judge' do |project|
        project.usability_grader
      end
    end
  end

  controller do
    def scoped_collection
      super.includes(:student, :hack)
    end
  end
end
