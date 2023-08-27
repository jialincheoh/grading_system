class ScoresController < ApplicationController
  before_action :ensure_grader_logged_in

  def index
    if params[:phase].present? && params[:phase] != "All Phases"
      @grades = Grade
                  .includes(:grader)
                  .where(phase: params[:phase])
                  .joins(project: :hack)
                  .where('hacks.name = ?', params[:hack])
                  .includes(project: [:hack, :student])
                  .order(:phase)
    else
      @grades = Grade
                  .includes(:grader)
                  .where.not(phase: nil)
                  .joins(project: :hack)
                  .where('hacks.name = ?', params[:hack])
                  .includes(project: [:hack, :student])
                  .order(:phase)
    end

    usability_grades = @grades.where(usability: true).uniq
    technical_grades = @grades.where(technical: true).uniq

    ue_scores_data = []
    iv_scores_data = []
    nov_scores_data = []

    # for purdue and bogota projects
    new_nov_scores_data = []

    usability_grades.each do |ug|
      ue_scores_data << ug.total_user_experience_score
      iv_scores_data << ug.total_info_visualization_score
      nov_scores_data << ug.total_novelty_score
      new_nov_scores_data << ug.design_relevance_score
    end

    tech_scores_data = technical_grades.map { |tg| tg.total_technical_score }

    @ue_avg = ue_scores_data.mean
    @iv_avg = iv_scores_data.mean
    @nov_avg = nov_scores_data.mean
    @new_nov_avg = new_nov_scores_data.mean
    @tech_avg = tech_scores_data.mean

    @ue_std_dev =  ue_scores_data.standard_deviation
    @iv_std_dev =  iv_scores_data.standard_deviation
    @nov_std_dev =  nov_scores_data.standard_deviation
    @new_nov_std_dev =  new_nov_scores_data.standard_deviation
    @tech_std_dev =  tech_scores_data.standard_deviation

    @ue_q1 = ue_scores_data.descriptive_statistics[:q1]
    @iv_q1 = iv_scores_data.descriptive_statistics[:q1]
    @nov_q1 = nov_scores_data.descriptive_statistics[:q1]
    @new_nov_q1 = new_nov_scores_data.descriptive_statistics[:q1]
    @tech_q1 = tech_scores_data.descriptive_statistics[:q1]

    @ue_q2 = ue_scores_data.descriptive_statistics[:q2]
    @iv_q2 = iv_scores_data.descriptive_statistics[:q2]
    @nov_q2 = nov_scores_data.descriptive_statistics[:q2]
    @new_nov_q2 = new_nov_scores_data.descriptive_statistics[:q2]
    @tech_q2 = tech_scores_data.descriptive_statistics[:q2]

    @ue_q3 = ue_scores_data.descriptive_statistics[:q3]
    @iv_q3 = iv_scores_data.descriptive_statistics[:q3]
    @nov_q3 = nov_scores_data.descriptive_statistics[:q3]
    @new_nov_q3 = new_nov_scores_data.descriptive_statistics[:q3]
    @tech_q3 = tech_scores_data.descriptive_statistics[:q3]

    @ue_max = ue_scores_data.descriptive_statistics[:max]
    @iv_max = iv_scores_data.descriptive_statistics[:max]
    @nov_max = nov_scores_data.descriptive_statistics[:max]
    @new_nov_max = new_nov_scores_data.descriptive_statistics[:max]
    @tech_max = tech_scores_data.descriptive_statistics[:max]
  end

  def total_scores
    @hack = Hack.find_by(name: params[:hack] || 'Bogota-Hack-0-2017')
    @projects = Project.joins(:hack).where(hacks: { name: @hack.name }).includes(:hack, :student)
    @project_ids = @projects.pluck(:id)

    if params[:phase].present? && params[:phase] != "All Phases"
      @phases = [params[:phase]]
    elsif params[:phase] == "All Phases"
      @phases = ["1st Phase", "2nd Phase", "3rd Phase", "4th Phase", "5th Phase", "Final Phase"]
    else
      @phases = ["1st Phase"]
    end
  end

  def ensure_grader_logged_in
    unless current_grader.present?
      flash[:error] = 'You are not authorized to see this page! Please sign in to see the page'
      redirect_to new_grader_session_path
    end
  end
end
