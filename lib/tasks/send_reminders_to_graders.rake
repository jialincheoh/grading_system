namespace :graders do
  desc "technical graders: send reminder emails to"
  task send_reminder_email_to_technical_graders: :environment do
    Project.all.each do |project|
      next if project.technical_grader.nil?
      puts "sending email to technical grader: #{project.technical_grader.try(:email)}"
      GraderMailer.reminder_email(project.technical_grader, project.id).deliver_now
    end
  end

  desc "usability graders: send reminder emails to"
  task send_reminder_email_to_usability_graders: :environment do
    Project.all.each do |project|
      next if project.usability_grader.nil?
      grades = project.grades.where.not(novelty_1_text: nil).where(usability: true)
      grades.each do |grade|
        puts "sending email to usability grader: #{project.usability_grader.try(:email)}"
        GraderMailer.reminder_email(project.usability_grader, project.id, grade.id).deliver_now
      end
    end
  end
end
