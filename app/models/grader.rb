class Grader < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :send_welcome_mail

  has_many :grades
  has_many :projects, through: :grades

  def technical_expert?
    grader_type == "Technical Expert"
  end

  def user_interface_expert?
    grader_type == "User Interface Expert"
  end

  def gold_ironhack_projects
    projects.where('projects.hack_id = ?', Hack.find_by(name: "Gold IronHack").id).uniq
  end

  def black_ironhack_projects
    projects.where('projects.hack_id = ?', Hack.find_by(name: "Black IronHack").id).uniq
  end

  def bogota_ironhack_projects(bogota_hack_number)
    projects.where('projects.hack_id = ?', Hack.find_by(name: "Bogota-Hack-#{bogota_hack_number}-2017").id).uniq
  end

  def purdue_ironhack_projects(purdue_hack_number)
    projects.where('projects.hack_id = ?', Hack.find_by(name: "Purdue-Hack-#{purdue_hack_number}-2017").id).uniq
  end

  def platzi_ironhack_projects
    projects.where('projects.hack_id = ?', Hack.find_by(name: "Platzi").id).uniq
  end

  private

  def send_welcome_mail
    GraderMailer.welcome_email(self).deliver
  end
end
