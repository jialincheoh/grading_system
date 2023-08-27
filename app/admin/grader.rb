ActiveAdmin.register Grader do
  permit_params :name, :email, :grader_type, :hack_name

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :grader_type
    column :hack_name
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :grader_type, as: :select, collection: ["Technical Expert", "User Interface Expert"]
      f.input :email
      f.input :hack_name, as: :select, collection: Hack.pluck(:name)
    end
    f.actions
  end
end
