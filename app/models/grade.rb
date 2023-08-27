class Grade < ActiveRecord::Base
  belongs_to :project
  belongs_to :grader

  validate :grade_phase, on: :create
  #
  # validates_presence_of :tech_criteria_1,
  #                       :tech_criteria_2,
  #                       :tech_criteria_3,
  #                       :tech_criteria_4,
  #                       :tech_criteria_5,
  #                       :tech_criteria_6,
  #                       :tech_criteria_7,
  #                       :tech_criteria_8,
  #                       :tech_criteria_9,
  #                       :tech_criteria_10,
  #                       :tech_criteria_11,
  #                       :major_errors,
  #                       :moderate_errors,
  #                       :minor_errors,
  #                       if: -> { grader.technical_expert? }
  #
  # validates_presence_of :non_tech_criteria_1,
  #                       :non_tech_criteria_2,
  #                       :non_tech_criteria_3,
  #                       :non_tech_criteria_4,
  #                       :non_tech_criteria_5,
  #                       :non_tech_criteria_6,
  #                       :non_tech_criteria_7,
  #                       :non_tech_criteria_8,
  #                       :non_tech_criteria_9,
  #                       :non_tech_criteria_10,
  #                       :non_tech_criteria_11,
  #                       if: -> { grader.user_interface_expert? }

  CRITERIA_CODE_TO_DESC_MAP = {
    # tech criterias for gold and black
    'tech_criteria_1' => 'The application uses the mandatory dataset: Climate Data Online',
    'tech_criteria_2' => 'Using JavaScript, and adhere to the rules of the W3 School',
    'tech_criteria_3' => 'The application uses at least one dataset from Data.gov that was released by the State of Indiana',
    'tech_criteria_4' => 'The application is written in JavaScript language',
    'tech_criteria_5' => 'The website integrates a mashup',
    'tech_criteria_6' => 'The code submission is complemented with a readme file',
    'tech_criteria_7' => 'Does the readme have: Keywords, brief description, a unique identifier of the author, browser within which it was tested (has to be Chrome)',
    'tech_criteria_8' => 'The application uses one of the libraries suggested (arbor js, D3 js, sigma js, other libraries)',
    'tech_criteria_9' => 'List how many datasets used in this App',
    'tech_criteria_10' => 'How many dataset from Data DOT gov?',
    'tech_criteria_11' => 'Does this app use Googlemap API?',
    # tech criterias for bogota
    'tech_criteria_1_bogota_ironhack' => 'The application uses the mandatory dataset: Climate Data Online (http://catalog DOT data DOT gov/dataset/climate-data-online-cdo)',
    'tech_criteria_2_bogota_ironhack' => 'The application uses at least two datasets; the climate data online and one from DataDOTgov focusing on Chicago (it is required to use one of our 50 recommended datasets already introduced in the tutorial sessions); see our tutorial',
    'tech_criteria_3_bogota_ironhack' => 'The predefined starting location of the Google map needs to be in place (41DOT8708°N, 87DOT6505°W)',
    'tech_criteria_4_bogota_ironhack' => 'The application is written in JavaScript language',
    'tech_criteria_5_bogota_ironhack' => 'The website integrates a mashup (typically has three components:map, interactive charts, user input forms)',
    'tech_criteria_6_bogota_ironhack' => 'The code submission is complemented with a readme file',
    'tech_criteria_7_bogota_ironhack' => 'Does the readme have: Keywords, brief description, a unique identifier of the author, browser within which it was tested (has to be Chrome)',
    'tech_criteria_8_bogota_ironhack' => 'The application uses one of the four libraries (arbor js, C3 js, D3 js, sigma js)',
    # tech criterias for purdue
    'tech_criteria_1_purdue_ironhack' => 'The application uses the mandatory dataset: Climate Data Online (http://catalog DOT data DOT gov/dataset/climate-data-online-cdo)',
    'tech_criteria_2_purdue_ironhack' => 'The application uses at least one additional dataset from DataDOTgov or Open Indy Portal (we require you to use one of 50 datasets that we have screened for you; please check out our tutorials)',
    'tech_criteria_3_purdue_ironhack' => 'The application uses the Google API',
    'tech_criteria_4_purdue_ironhack' => 'The application is written in JavaScript language',
    'tech_criteria_5_purdue_ironhack' => 'The website should integrate a mashup -- a web page or application created by combining data or functionality from different sources',
    'tech_criteria_6_purdue_ironhack' => 'The code submission is complemented with a readme file',
    'tech_criteria_7_purdue_ironhack' => 'Does the readme have: Keywords, brief description, a unique identifier of the author, browser within which it was tested (has to be Chrome)',
    'tech_criteria_8_purdue_ironhack' => 'The application uses one of the four libraries (arbor js, C3 js, D3 js, sigma js)',
    # non-tech criterias for gold
    'non_tech_criteria_1' => 'The application/mash-up is developed for the users in West Lafayette/ Lafayette and the Greater Lafayette Area',
    'non_tech_criteria_2' => 'The application/mash-up provides at least 2 options (locations) for buying vegetables in West Lafayette/Lafayette and the Greater Lafayette Area',
    'non_tech_criteria_3' => 'The application/mash-up provides buying options with the information of freshness to the users',
    'non_tech_criteria_4' => 'The application/mash-up provides buying options with estimated prices to the users',
    'non_tech_criteria_5' => 'The application/mash-up provides the info that helps the users decide and compare where to go to buy (e g weather, products, prices, transportation etc)',
    'non_tech_criteria_6' => 'The page layout design in the App/mash-up is efficient (design)',
    'non_tech_criteria_7' => 'The user interface offers perceived interaction from the existing elements that can be understood by the user (functionality)',
    'non_tech_criteria_8' => 'The grouping of elements in the App/mash-up is efficient and effective (design)',
    'non_tech_criteria_9' => 'The user interface offers minimal necessary actions (in 3 steps) to find an option (functionality)',
    'non_tech_criteria_10' => 'The interface reduces cognitive load (eg By color coding, icons and other visual features and elements) (design)',
    'non_tech_criteria_11' => 'The user does not have to memorize a lot of information to find the alternative option (functionality)',
    # non-tech criterias for black ironhack
    'non_tech_criteria_1_black_ironhack' => 'The application/mash-up is developed for app users that want to travel from the Greater Lafayette Area  to Florida',
    'non_tech_criteria_2_black_ironhack' => 'The application/mash-up provides at least 2 travel options (locations, transporation modes, or routes) for traveling to Florida',
    'non_tech_criteria_3_black_ironhack' => 'The application/mash-up provides information about viruses',
    'non_tech_criteria_4_black_ironhack' => 'The application/mash-up provides information about  estimated (indicated) virus infection risk',
    'non_tech_criteria_5_black_ironhack' => 'The application/mash-up provides information that helps the users to compare possible travel options based on any additional criteria (eg weather, distance, density of population, social interaction intensity, type of transporation)',
    'non_tech_criteria_6_black_ironhack' => 'The page layout design in the App/mash-up is efficient (design)',
    'non_tech_criteria_7_black_ironhack' => 'The user interface offers perceivable interactions via the visual elements that lead to expected results (functionality)',
    'non_tech_criteria_8_black_ironhack' => 'The grouping of elements in the App/mash-up is efficient and effective (design)',
    'non_tech_criteria_9_black_ironhack' => 'The user interface offers minimal necessary actions (in 3 steps or less) to find an option (functionality)',
    'non_tech_criteria_10_black_ironhack' => 'The interface reduces cognitive load, eg, by color coding, icons and other visual features and elements (design)',
    'non_tech_criteria_11_black_ironhack' => 'The user does not have to memorize a lot of information to find alternative options and choose their preference (functionality)',
    # non-tech criterias for bogota ironhack
    'non_tech_criteria_1_bogota_ironhack' => 'The application/mash-up is developed for new students moving to Chicago, IL',
    'non_tech_criteria_2_bogota_ironhack' => 'The application/mash-up shows at least 2 renting options near the Computer Science building at University of Illinois, Chicago',
    'non_tech_criteria_3_bogota_ironhack' => 'The application/mash-up shows the safest renting option close to the Computer Science building at University of Illinois, Chicago',
    'non_tech_criteria_4_bogota_ironhack' => 'The application/mash-up shows the renting option with the cheapest rental price (actual or relative) close to University of Illinois, Chicago',
    'non_tech_criteria_5_bogota_ironhack' => 'The application/mash-up shows criteria that helps new students compare renting options near the Computer Science building at University of Illinois, Chicago (e.g. room and bathroom number in the rental options, building type, distance to university, parks/greenery, restaurants/bars, sport facilities, transportation, etc.)',
    'non_tech_criteria_6_bogota_ironhack' => 'The page layout design in the App/mash-up is efficient (design). Please also test layout at zoom levels 150% and 175%',
    'non_tech_criteria_7_bogota_ironhack' => 'The user interface offers perceivable interactions via the visual elements that lead to expected results (functionality)',
    'non_tech_criteria_8_bogota_ironhack' => 'The grouping of elements in the App/mash-up is effective (design)',
    'non_tech_criteria_9_bogota_ironhack' => 'The user interface offers minimal necessary actions to find an option (functionality)',
    'non_tech_criteria_10_bogota_ironhack' => 'The interface reduces cognitive load, e.g., by color coding, icons and other visual features (design)',
    'non_tech_criteria_11_bogota_ironhack' => 'The user does not have to memorize a lot of information to compare alternative renting options and choose their preference (functionality)',
    # non-tech criterias for purdue
    'non_tech_criteria_1_purdue_ironhack' => 'The application/mash-up is developed for the users in  West Lafayette/Lafayette and the Greater Lafayette Area',
    'non_tech_criteria_2_purdue_ironhack' => 'The application/mash-up provides at least 2 options (locations) for buying vegetables in West Lafayette/Lafayette and the Greater Lafayette Area',
    'non_tech_criteria_3_purdue_ironhack' => 'The application/mash-up provides buying options with the information of freshness to the users',
    'non_tech_criteria_4_purdue_ironhack' => 'The application/mash-up provides buying options with estimated prices to the users',
    'non_tech_criteria_5_purdue_ironhack' => 'The application/mash-up provides the info that helps the users decide and compare where to go to buy (e g weather, products, prices, transportation etc)',
    'non_tech_criteria_6_purdue_ironhack' => 'The page layout design in the App/mash-up is efficient (design)',
    'non_tech_criteria_7_purdue_ironhack' => 'The user interface offers perceivable interactions via the visual elements that lead to expected results (functionality)',
    'non_tech_criteria_8_purdue_ironhack' => 'The grouping of elements in the App/mash-up is efficient and effective (design)',
    'non_tech_criteria_9_purdue_ironhack' => 'The user interface offers minimal necessary actions (in 3 steps or less) to find an option (functionality)',
    'non_tech_criteria_10_purdue_ironhack' => 'The interface reduces cognitive load (eg By color coding, icons and other visual features and elements) (design)',
    'non_tech_criteria_11_purdue_ironhack' => 'The user does not have to memorize a lot of information to find alternative options and choose their preference (functionality)',
    # non-tech criterias for platzi
    'non_tech_criteria_1_platzi_ironhack' => 'The application/mash-up is developed for new students moving to New York City, NY.',
    'non_tech_criteria_2_platzi_ironhack' => 'The application/mash-up shows at least 2 renting options near New York City, NY.',
    'non_tech_criteria_3_platzi_ironhack' => 'The application/mash-up shows the safest renting option close to New York City, NY.',
    'non_tech_criteria_4_platzi_ironhack' => 'The application/mash-up shows the renting option with the cheapest rental price (actual or relative) close to New York City, NY.',
    'non_tech_criteria_5_platzi_ironhack' => 'The application/mash-up shows criteria that helps new students compare renting options near the university (e.g. weather, distance to university, proximity to parks/greenery, access to restaurants/bars, proximity to sport facilities, transportation, etc.).',
    'non_tech_criteria_6_platzi_ironhack' => 'The page layout design in the App/mash-up is efficient (design). Please test layout at zoom levels 150% and 175%.',
    'non_tech_criteria_7_platzi_ironhack' => 'The user interface offers perceivable interactions (links, clicks, sliderst, etc.) via its visual elements that lead to expected results (functionality).',
    'non_tech_criteria_8_platzi_ironhack' => 'The grouping of elements in the App/mash-up is effective (design).',
    'non_tech_criteria_9_platzi_ironhack' => 'The user interface offers minimal necessary actions to find an option (functionality).',
    'non_tech_criteria_10_platzi_ironhack' => 'The interface reduces cognitive load, e.g., by color coding, icons and visual features that change after being clicked (design).',
    'non_tech_criteria_11_platzi_ironhack' => 'The user does not have to memorize a lot of information to compare alternative renting options and choose their preference (functionality).'
  }

  def total_technical_score
    sum = 0
    (1..8).each do |index|
      sum += send("tech_criteria_#{index}").to_f
    end
    (sum * 12.5) - total_errors
  end

  def total_user_experience_score
    sum_1 = 0
    (1..5).each do |index|
      sum_1 += send("non_tech_criteria_#{index}").to_f
    end

    sum_1 * 20.0
  end

  def total_info_visualization_score
    sum_2 = 0
    (6..11).each do |index|
      val = send("non_tech_criteria_#{index}")
      next if val.nil?
      value = val.to_f
      sum_2 += ((value - 4) * (-1))
    end

    sum_2 * 100 / 24
  end

  def total_novelty_score
    sum = 0
    (1..5).each do |index|
      relevance_score = send("novelty_#{index}_score")
      design_score = send("novelty_#{index}_design_score")
      functionality_score = send("novelty_#{index}_functionality_score")
      sum += apply_novelty_formula(relevance_score) + apply_novelty_formula(design_score) + apply_novelty_formula(functionality_score)
    end
    sum
  end

  def apply_novelty_formula(value)
    value.present? ? (value - 4) * (-1) : 0
  end

  def novelty_fields_present?
    (1..5).any? { |index| send("novelty_#{index}_text").present? }
  end

  def novelty_fields_count
    count = 0
    (1..5).each do |index|
      count += 1 if send("novelty_#{index}_text").present?
    end
    count
  end

  # new formula for calculating total novelty score
  def design_relevance_score
    return 0 if novelty_fields_count == 0

    avg = 0
    (1..5).each do |index|
      relevance_score = send("novelty_#{index}_score")
      design_score = send("novelty_#{index}_design_score")
      avg += (apply_novelty_formula(relevance_score) + apply_novelty_formula(design_score)).to_f / 2
    end
    (avg / novelty_fields_count) * 25
  end

  def total_errors
    (major_errors * 3) + (moderate_errors * 2) + minor_errors
  end

  def technical_grade?
    technical == true
  end

  def usability_grade?
    usability == true
  end

  # TODO: Optimize this method
  # hint: use joins and includes and get rid of select
  def percentage_below_technical_score
    my_tech_score = self.total_technical_score
    all_participants_grades = Grade.includes(project: :hack)
                                .where(technical: true, phase: self.phase)
                                .uniq
                                .select { |g| g.project.hack == project.hack }
    count = 0
    all_participants_grades.each do |grade|
      next if grade == self
      count += 1 if (my_tech_score - grade.total_technical_score) > 0
    end

    if all_participants_grades.present?
      (count.to_f / all_participants_grades.count) * 100.0
    else
      'nil'
    end
  end

  # TODO: Optimize this method
  # hint: use joins and includes and get rid of select
  def percentage_below_user_experience_score
    my_ue_score = self.total_user_experience_score
    all_participants_grades = Grade.includes(project: :hack)
                                .where(usability: true, phase: self.phase)
                                .uniq
                                .select { |g| g.project.hack == project.hack }
    count = 0
    all_participants_grades.each do |grade|
      next if grade == self
      count += 1 if (my_ue_score - grade.total_user_experience_score) > 0
    end

    if all_participants_grades.present?
      (count.to_f / all_participants_grades.count) * 100.0
    else
      'nil'
    end
  end

  # TODO: Optimize this method
  # hint: use joins and includes and get rid of select
  def percentage_below_info_visualization_score
    my_iv_score = self.total_info_visualization_score
    all_participants_grades = Grade.includes(project: :hack)
                                .where(usability: true, phase: self.phase)
                                .uniq
                                .select { |g| g.project.hack == project.hack }
    count = 0
    all_participants_grades.each do |grade|
      next if grade == self
      count += 1 if (my_iv_score - grade.total_info_visualization_score) > 0
    end

    if all_participants_grades.present?
      (count.to_f / all_participants_grades.count) * 100.0
    else
      'nil'
    end
  end

  # TODO: Optimize this method
  # hint: use joins and includes and get rid of select
  def percentage_below_novelty_score
    my_novelty_score = self.total_novelty_score
    all_participants_grades = Grade.includes(project: :hack)
                              .where(usability: true, phase: self.phase)
                              .uniq
                              .select { |g| g.project.hack == project.hack }
    count = 0
    all_participants_grades.each do |grade|
      next if grade == self
      count += 1 if (my_novelty_score - grade.total_novelty_score) > 0
    end

    if all_participants_grades.present?
      (count.to_f / all_participants_grades.count) * 100.0
    else
      'nil'
    end
  end

  def percentage_below_new_novelty_score
    my_novelty_score = self.design_relevance_score
    all_participants_grades = Grade.includes(project: :hack)
                                .where(usability: true, phase: self.phase)
                                .uniq
                                .select { |g| g.project.hack == project.hack }
    count = 0
    all_participants_grades.each do |grade|
      next if grade == self
      count += 1 if (my_novelty_score - grade.design_relevance_score) > 0
    end

    if all_participants_grades.present?
      (count.to_f / all_participants_grades.count) * 100.0
    else
      'nil'
    end
  end

  def grade_phase
    if technical_grade?
      if project.grades.where(technical: true).uniq.pluck(:phase).include? phase
        errors.add(:phase, "Error: Grade for #{phase} is already submitted. You can edit the #{phase} grade from the grades page. Or, submit grade for a new phase")
      end
    elsif usability_grade?
      if project.grades.where(usability: true).uniq.pluck(:phase).include? phase
        errors.add(:phase, "Error: Grade for #{phase} is already submitted. You can edit the #{phase} grade from the grades page. Or, submit grade for a new phase")
      end
    end
  end
end
