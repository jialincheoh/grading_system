class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    if current_grader.present?
      @projects = current_grader.projects.select('projects.*, LOWER(projects.name)').includes(:hack, :student).order('LOWER(projects.name)').uniq
    else
      redirect_to new_grader_registration_path
    end
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
    end
  end

  def download
    data = []
    Hack.all.each do |hack|
      hack.projects.each do |project|
        tech_data = []
        ux_data = []
        project_data = { name: project.name, hack: hack.name }

        project.grades.uniq.each do |grade|
          if grade.technical_grade?
            tech_data << build_tech_grades_data(project, grade)
          elsif grade.usability_grade?
            ux_data << build_ux_grades_data(project, grade)
          end
        end
        project_data['tech_grades'] = tech_data
        project_data['ux_grades'] = ux_data
        data << project_data
      end
    end
    render json: { projects: data }
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:name, :web_url, :student_id, :read_me_url, :hack_id)
  end

  def build_tech_grades_data(project, grade)
    data = {}
    range = (project.gold_ironhack? || project.black_ironhack?) ? (1..11) : (1..8)

    range.each do |index|
      key = if project.gold_ironhack? || project.black_ironhack?
        Grade::CRITERIA_CODE_TO_DESC_MAP["tech_criteria_#{index}"]
      elsif project.bogota_ironhack? || project.platzi_ironhack?
        Grade::CRITERIA_CODE_TO_DESC_MAP["tech_criteria_#{index}_bogota_ironhack"]
      elsif project.purdue_ironhack?
        Grade::CRITERIA_CODE_TO_DESC_MAP["tech_criteria_#{index}_purdue_ironhack"]
      end

      value = grade.send("tech_criteria_#{index}").to_f
      data[key] = value
    end
    data

    { phase: grade.phase, score: data }
  end

  def build_ux_grades_data(project, grade)
    data = {}
    (1..11).each do |index|
      key = if project.bogota_ironhack?
        Grade::CRITERIA_CODE_TO_DESC_MAP["non_tech_criteria_#{index}_bogota_ironhack"]
      elsif project.platzi_ironhack?
        Grade::CRITERIA_CODE_TO_DESC_MAP["non_tech_criteria_#{index}_platzi_ironhack"]
      elsif project.purdue_ironhack?
        Grade::CRITERIA_CODE_TO_DESC_MAP["non_tech_criteria_#{index}_purdue_ironhack"]
      elsif project.gold_ironhack?
        Grade::CRITERIA_CODE_TO_DESC_MAP["non_tech_criteria_#{index}"]
      elsif project.black_ironhack?
        Grade::CRITERIA_CODE_TO_DESC_MAP["non_tech_criteria_#{index}_black_ironhack"]
      end

      value = grade.send("non_tech_criteria_#{index}").to_f
      data[key] = value
    end
    data

    { phase: grade.phase, score: data }
  end
end
