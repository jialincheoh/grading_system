class GradesController < ApplicationController
  before_action :set_grade, only: [:show, :edit, :update, :destroy]
  before_action :set_project, except: [:technical_grading_instructions]
  before_action :ensure_valid_grader_logged_in, only: [:edit, :update, :destroy]
  before_action :ensure_current_grader

  def index
    @project = Project.find(params[:project_id])
    @grades = @project.grades.where.not(phase: nil).includes(:grader).order('graders.email')
  end

  def show
  end

  def new
    @grade = @project.grades.new
  end

  def edit
  end

  def create
    @grade = @project.grades.new(grade_params)
    if @grade.save
      flash[:success] = 'Grade was successfully created.'
      redirect_to project_grade_path(@project, @grade)
    else
      render :new
    end
  end

  def new_novelty_fields
    @grade = @project.grades.new
  end

  def create_novelty_fields
    @grade = @project.grades.new(grade_params)

    respond_to do |format|
      if @grade.save
        flash[:success] = 'Grade with Novelty Fields was successfully created.'
        GraderMailer.project_assigned_email(@project.usability_grader, @project.id, @grade.id).deliver_now
        format.html { redirect_to project_grade_path(@project, @grade) }
      else
        format.html { render :new }
      end
    end
  end

  def list_novelty_fields
    @usability_grades = @project.grades.where(usability: true)
  end

  def show_novelty_fields
    @grade = Grade.find(params[:grade_id])
  end

  def edit_novelty_fields
    @grade = Grade.find(params[:grade_id])
  end

  def update_novelty_fields
    @grade = Grade.find(params[:grade_id])
    if @grade.update(grade_params)
      flash[:success] = 'Novelty Fields were successfully updated.'
      redirect_to project_grade_show_novelty_fields_path(@project, @grade)
    else
      redirect_to project_grade_edit_novelty_fields_path(@project, @grade)
    end
  end

  def update
    respond_to do |format|
      if @grade.update(grade_params)
        flash[:success] = 'Grade was successfully updated.'
        format.html { redirect_to [@project, @grade] }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @grade.destroy
    respond_to do |format|
      flash[:success] = 'Grade was successfully destroyed.'
      format.html { redirect_to project_grades_url(@project) }
    end
  end

  def usability_grading_instructions
  end

  def technical_grading_instructions
  end

  def download
    @grade = Grade.find(params[:grade_id])
    data = build_downloadable_data
    file_name = "#{@grade.project.student.name}_#{@grade.phase}_#{@grade.project.hack.name}".gsub(" ", "")
    send_data data, type: "text/csv", filename: "#{file_name}.csv"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grade
      @grade = Grade.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grade_params
      params
        .require(:grade)
        .permit(
          :project_id,
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
        )
    end

  def ensure_valid_grader_logged_in
    unless current_grader.present? && @grade.present? && (@grade.grader == current_grader)
      flash[:error] = 'You are not authorized to see this page! Please sign in to see the page'
      redirect_to signout_path and return
    end
  end

  def ensure_current_grader
    unless current_grader
      flash[:error] = 'You are not authorized to see this page! Please sign in to see the page'
      redirect_to new_grader_session_path and return
    end
  end

  def build_downloadable_data
    data_str = ""
    data_str += "Student: #{@grade.project.student.name}\n"
    data_str += "Project Link: #{@grade.project.web_url}\n"
    data_str += "Phase: #{@grade.phase}\n"
    data_str += "\n\n"

    if @grade.usability_grade?
      if @grade.project.gold_ironhack?
        data_str += "User Experience Score: \n\n"
        data_str += "The primary measure for this performance dimension relates to the fullfillment of user requirements specified in the hacking task e.g. was the app developed for citizens living in Lafayette \n\n"
        data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['non_tech_criteria_1']}: #{@grade.non_tech_criteria_1}\n"
        data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['non_tech_criteria_2']}: #{@grade.non_tech_criteria_2}\n"
        data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['non_tech_criteria_3']}: #{@grade.non_tech_criteria_3}\n"
        data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['non_tech_criteria_4']}: #{@grade.non_tech_criteria_4}\n"
        data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['non_tech_criteria_5']}: #{@grade.non_tech_criteria_5}\n"
        data_str += "\n\n"
        data_str += "Info Visualization Score: \n\n"
        data_str += "In the dimension of Information Visualization we focus on three core aspects: System affordance: Does the application offer recognizable elements and interactions that can be understood by the user? Cognitive workload: Is the number of alternatives from which the user can choose appropriate? Functionality: Would a potential user have to memorize a lot of information to carry the task? \n\n"
        data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['non_tech_criteria_6']}: #{@grade.non_tech_criteria_6}\n"
        data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['non_tech_criteria_7']}: #{@grade.non_tech_criteria_7}\n"
        data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['non_tech_criteria_8']}: #{@grade.non_tech_criteria_8}\n"
        data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['non_tech_criteria_9']}: #{@grade.non_tech_criteria_9}\n"
        data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['non_tech_criteria_10']}: #{@grade.non_tech_criteria_10}\n"
        data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['non_tech_criteria_11']}: #{@grade.non_tech_criteria_11}\n"
      elsif @grade.project.black_ironhack?
        data_str += "User Experience Score: \n\n"
        data_str += "VIRUS & DISEASE WEB APPLICATION: Track disease probability through movement and geography \n\n"
        data_str += "The primary measure for this performance dimension relates to the fullfillment of user requirements specified in the hacking task e.g. was the app developed for citizens living in Lafayette \n\n"
        data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['non_tech_criteria_1_black_ironhack']}: #{@grade.non_tech_criteria_1}\n"
        data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['non_tech_criteria_2_black_ironhack']}: #{@grade.non_tech_criteria_2}\n"
        data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['non_tech_criteria_3_black_ironhack']}: #{@grade.non_tech_criteria_3}\n"
        data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['non_tech_criteria_4_black_ironhack']}: #{@grade.non_tech_criteria_4}\n"
        data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['non_tech_criteria_5_black_ironhack']}: #{@grade.non_tech_criteria_5}\n"
        data_str += "\n\n"
        data_str += "Info Visualization Score: \n\n"
        data_str += "In the dimension of Information Visualization we focus on three core aspects: System affordance: Does the application offer recognizable elements and interactions that can be understood by the user? Cognitive workload: Is the number of alternatives from which the user can choose appropriate? Functionality: Would a potential user have to memorize a lot of information to carry the task? \n\n"
        data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['non_tech_criteria_6_black_ironhack']}: #{@grade.non_tech_criteria_6}\n"
        data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['non_tech_criteria_7_black_ironhack']}: #{@grade.non_tech_criteria_7}\n"
        data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['non_tech_criteria_8_black_ironhack']}: #{@grade.non_tech_criteria_8}\n"
        data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['non_tech_criteria_9_black_ironhack']}: #{@grade.non_tech_criteria_9}\n"
        data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['non_tech_criteria_10_black_ironhack']}: #{@grade.non_tech_criteria_10}\n"
        data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['non_tech_criteria_11_black_ironhack']}: #{@grade.non_tech_criteria_11}\n"
      end
      data_str += "\n\n"
      data_str += "Novelty Score: \n\n"
      if @grade.novelty_1_text.present?
        data_str += "Novely is evaluated with respect to three dimensions: Does your App include features generated from open datasets? How relevant is the data for the App and how well is the data designed and implemented?\n"
        data_str += "#{@grade.novelty_1_text}\n"
        data_str += "How relevant is the dataset to user's goal? (ie, how valuable is it to include the dataset, without any consideration to the execution) 0- data set is very relevant (should be included); 3 - irrelevant (can be removed): #{@grade.novelty_1_score}\n"
        data_str += "Quality of Execution (How the data is visualised and funcionalized in the mash up? 0-no design or functional issues; 1-cosmetic design issue, 2-functional issue (eg, design hinders cognition or data not functional enough to support user goals); 3-has to be fixed for launch (eg, broken urls, misleading design): #{@grade.novelty_1_design_score}\n"
        data_str += "\n\n"
      end
      if @grade.novelty_2_text.present?
        data_str += "Novely is evaluated with respect to three dimensions: Does your App include features generated from open datasets? How relevant is the data for the App and how well is the data designed and implemented?\n"
        data_str += "#{@grade.novelty_2_text}\n"
        data_str += "How relevant is the dataset to user's goal? (ie, how valuable is it to include the dataset, without any consideration to the execution) 0- data set is very relevant (should be included); 3 - irrelevant (can be removed): #{@grade.novelty_2_score}\n"
        data_str += "Quality of Execution (How the data is visualised and funcionalized in the mash up? 0-no design or functional issues; 1-cosmetic design issue, 2-functional issue (eg, design hinders cognition or data not functional enough to support user goals); 3-has to be fixed for launch (eg, broken urls, misleading design): #{@grade.novelty_2_design_score}\n"
        data_str += "\n\n"
      end
      if @grade.novelty_3_text.present?
        data_str += "Novely is evaluated with respect to three dimensions: Does your App include features generated from open datasets? How relevant is the data for the App and how well is the data designed and implemented?\n"
        data_str += "#{@grade.novelty_3_text}\n"
        data_str += "How relevant is the dataset to user's goal? (ie, how valuable is it to include the dataset, without any consideration to the execution) 0- data set is very relevant (should be included); 3 - irrelevant (can be removed): #{@grade.novelty_3_score}\n"
        data_str += "Quality of Execution (How the data is visualised and funcionalized in the mash up? 0-no design or functional issues; 1-cosmetic design issue, 2-functional issue (eg, design hinders cognition or data not functional enough to support user goals); 3-has to be fixed for launch (eg, broken urls, misleading design): #{@grade.novelty_3_design_score}\n"
        data_str += "\n\n"
      end
      if @grade.novelty_4_text.present?
        data_str += "Novely is evaluated with respect to three dimensions: Does your App include features generated from open datasets? How relevant is the data for the App and how well is the data designed and implemented?\n"
        data_str += "#{@grade.novelty_4_text}\n"
        data_str += "How relevant is the dataset to user's goal? (ie, how valuable is it to include the dataset, without any consideration to the execution) 0- data set is very relevant (should be included); 3 - irrelevant (can be removed): #{@grade.novelty_4_score}\n"
        data_str += "Quality of Execution (How the data is visualised and funcionalized in the mash up? 0-no design or functional issues; 1-cosmetic design issue, 2-functional issue (eg, design hinders cognition or data not functional enough to support user goals); 3-has to be fixed for launch (eg, broken urls, misleading design): #{@grade.novelty_4_design_score}\n"
        data_str += "\n\n"
      end
      if @grade.novelty_5_text.present?
        data_str += "Novely is evaluated with respect to three dimensions: Does your App include features generated from open datasets? How relevant is the data for the App and how well is the data designed and implemented?\n"
        data_str += "#{@grade.novelty_5_text}\n"
        data_str += "How relevant is the dataset to user's goal? (ie, how valuable is it to include the dataset, without any consideration to the execution) 0- data set is very relevant (should be included); 3 - irrelevant (can be removed): #{@grade.novelty_5_score}\n"
        data_str += "Quality of Execution (How the data is visualised and funcionalized in the mash up? 0-no design or functional issues; 1-cosmetic design issue, 2-functional issue (eg, design hinders cognition or data not functional enough to support user goals); 3-has to be fixed for launch (eg, broken urls, misleading design): #{@grade.novelty_5_design_score}\n"
        data_str += "\n\n"
      end
    elsif @grade.technical_grade?
      data_str += "Technical Score: \n\n"
      data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['tech_criteria_1']}: #{@grade.tech_criteria_1}\n"
      data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['tech_criteria_2']}: #{@grade.tech_criteria_2}\n"
      data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['tech_criteria_3']}: #{@grade.tech_criteria_3}\n"
      data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['tech_criteria_4']}: #{@grade.tech_criteria_4}\n"
      data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['tech_criteria_5']}: #{@grade.tech_criteria_5}\n"
      data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['tech_criteria_6']}: #{@grade.tech_criteria_6}\n"
      data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['tech_criteria_7']}: #{@grade.tech_criteria_7}\n"
      data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['tech_criteria_8']}: #{@grade.tech_criteria_8}\n"
      data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['tech_criteria_9']}: #{@grade.tech_criteria_9}\n"
      data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['tech_criteria_10']}: #{@grade.tech_criteria_10}\n"
      data_str += "#{Grade::CRITERIA_CODE_TO_DESC_MAP['tech_criteria_11']}: #{@grade.tech_criteria_11}\n"
      data_str += "\n\n"
      data_str += "Errors: \n\n"
      data_str += "major_errors: #{@grade.major_errors}\n"
      data_str += "moderate_errors: #{@grade.moderate_errors}\n"
      data_str += "minor_errors: #{@grade.minor_errors}\n"
    end
    data_str
  end
end
