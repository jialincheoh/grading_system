class Project < ActiveRecord::Base

  GOLDIRONHACK_MAX_PER_TECH_GRADER = 16
  GOLDIRONHACK_MAX_PER_UX_GRADER = 16

  BLACKIRONHACK_MAX_PER_TECH_GRADER = 22
  BLACKIRONHACK_MAX_PER_UX_GRADER = 22

  BOGOTA_HACK_MAX_PER_TECH_GRADER = 55
  BOGOTA_HACK_MAX_PER_UX_GRADER = 9

  PURDUE_HACK_MAX_PER_TECH_GRADER = 55
  PURDUE_HACK_MAX_PER_UX_GRADER = 16

  PLATZI_HACK_MAX_PER_TECH_GRADER = 5
  PLATZI_HACK_MAX_PER_UX_GRADER = 2

  belongs_to :student
  belongs_to :hack

  has_many :grades, dependent: :destroy
  has_many :graders, through: :grades

  validates_presence_of :name, :hack_id
  validates_uniqueness_of :student_id, :allow_blank => true

  after_create :assign_graders

  def calculate_score_for(phase)
    all_grades = grades.where(phase: phase)
    total_score = 0
    technical_grade = all_grades.detect { |grade| grade.technical_grade? }
    usability_grade = all_grades.detect { |grade| grade.usability_grade? }

    if technical_grade.present?
      total_score += technical_grade.total_technical_score
    end

    if usability_grade.present?
      if bogota_ironhack? || purdue_ironhack?
        total_score += (usability_grade.total_user_experience_score + usability_grade.total_info_visualization_score + usability_grade.design_relevance_score)
      else
        total_score += (usability_grade.total_user_experience_score + usability_grade.total_info_visualization_score + usability_grade.total_novelty_score)
      end
    end

    if total_score < 0.001
      0
    else
      total_score
    end
  end

  def percentage_below_total_score(phase, project_ids)
    my_total_score = self.calculate_score_for(phase)
    count = 0
    Project.where(id: project_ids).find_each do |project|
      next if project == self
      count += 1 if (my_total_score - project.calculate_score_for(phase)) > 0
    end

    (count.to_f / project_ids.count) * 100.0
  end

  def technical_grader
    graders.where(grader_type: "Technical Expert").first
  end

  def usability_grader
    graders.where(grader_type: "User Interface Expert").first
  end

  def gold_ironhack?
    hack.name == 'Gold IronHack'
  end

  def black_ironhack?
    hack.name == 'Black IronHack'
  end

  def bogota_ironhack?
    (hack.name =~ /Bogota-Hack-\d+-2017/).present?
  end

  def purdue_ironhack?
    (hack.name =~ /Purdue-Hack-\d+-2017/).present?
  end

  def bogota_0_ironhack?
    hack.name == "Bogota-Hack-0-2017"
  end

  def bogota_1_ironhack?
    hack.name == "Bogota-Hack-1-2017"
  end

  def bogota_2_ironhack?
    hack.name == "Bogota-Hack-2-2017"
  end

  def bogota_3_ironhack?
    hack.name == "Bogota-Hack-3-2017"
  end

  def purdue_0_ironhack?
    hack.name == "Purdue-Hack-0-2017"
  end

  def platzi_ironhack?
    hack.name == "Platzi"
  end

  private

  def assign_graders
    technical_expert = get_next_technical_grader
    user_interface_expert = get_next_usability_grader
    self.graders << technical_expert
    self.graders << user_interface_expert
    send_email_to_graders([technical_expert])
  end

  def get_next_technical_grader
    tech_graders = Grader.where(grader_type: "Technical Expert")

    if gold_ironhack?
      tech_graders.detect { |grader| grader.gold_ironhack_projects.count < GOLDIRONHACK_MAX_PER_TECH_GRADER }
    elsif black_ironhack?
      tech_graders.detect { |grader| grader.black_ironhack_projects.count < BLACKIRONHACK_MAX_PER_TECH_GRADER }
    elsif bogota_0_ironhack?
      tech_graders.detect { |grader| grader.bogota_ironhack_projects(0).count < BOGOTA_HACK_MAX_PER_TECH_GRADER }
    elsif bogota_1_ironhack?
      tech_graders.detect { |grader| grader.bogota_ironhack_projects(1).count < BOGOTA_HACK_MAX_PER_TECH_GRADER }
    elsif bogota_2_ironhack?
      tech_graders.detect { |grader| grader.bogota_ironhack_projects(2).count < BOGOTA_HACK_MAX_PER_TECH_GRADER }
    elsif bogota_3_ironhack?
      tech_graders.detect { |grader| grader.bogota_ironhack_projects(3).count < BOGOTA_HACK_MAX_PER_TECH_GRADER }
    elsif purdue_0_ironhack?
      tech_graders.detect { |grader| grader.purdue_ironhack_projects(0).count < PURDUE_HACK_MAX_PER_TECH_GRADER }
    elsif platzi_ironhack?
      tech_graders.detect { |grader| grader.platzi_ironhack_projects.count < PLATZI_HACK_MAX_PER_TECH_GRADER }
    end
  end

  def get_next_usability_grader
    gold_ux_graders = Grader.where(grader_type: "User Interface Expert", hack_name: "Gold IronHack")
    black_ux_graders = Grader.where(grader_type: "User Interface Expert", hack_name: "Black IronHack")
    bogota_ux_graders = Grader.where(grader_type: "User Interface Expert").where("hack_name LIKE ?", "Bogota-Hack%")
    purdue_ux_graders = Grader.where(grader_type: "User Interface Expert").where("hack_name LIKE ?", "Purdue-Hack%")
    platzi_ux_graders = Grader.where(grader_type: "User Interface Expert", hack_name: "Platzi")

    if gold_ironhack?
      gold_ux_graders.detect { |grader| grader.gold_ironhack_projects.count < GOLDIRONHACK_MAX_PER_UX_GRADER }
    elsif black_ironhack?
      black_ux_graders.detect { |grader| grader.black_ironhack_projects.count < BLACKIRONHACK_MAX_PER_UX_GRADER }
    elsif bogota_0_ironhack?
      bogota_ux_graders.detect { |grader| grader.bogota_ironhack_projects(0).count < BOGOTA_HACK_MAX_PER_UX_GRADER }
    elsif bogota_1_ironhack?
      bogota_ux_graders.detect { |grader| grader.bogota_ironhack_projects(1).count < BOGOTA_HACK_MAX_PER_UX_GRADER }
    elsif bogota_2_ironhack?
      bogota_ux_graders.detect { |grader| grader.bogota_ironhack_projects(2).count < BOGOTA_HACK_MAX_PER_UX_GRADER }
    elsif bogota_3_ironhack?
      bogota_ux_graders.detect { |grader| grader.bogota_ironhack_projects(3).count < BOGOTA_HACK_MAX_PER_UX_GRADER }
    elsif purdue_0_ironhack?
      purdue_ux_graders.detect { |grader| grader.purdue_ironhack_projects(0).count < PURDUE_HACK_MAX_PER_UX_GRADER }
    elsif platzi_ironhack?
      platzi_ux_graders.detect { |grader| grader.platzi_ironhack_projects.count < PLATZI_HACK_MAX_PER_UX_GRADER }
    end
  end

  def send_email_to_graders(graders)
    graders.each do |grader|
      GraderMailer.project_assigned_email(grader, self.id).deliver_now
    end
  end
end
