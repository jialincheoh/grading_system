namespace :hack_2_project do
  desc "send performance reports to students for 1st phase"
  task send_email_to_students_1st_phase: :environment do
    Hack.find_by(name: "Black IronHack").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_performance_report_to(project, project.student, "1st Phase").deliver_now
    end
  end

  desc "send performance reports to students for 2nd phase"
  task send_email_to_students_2nd_phase: :environment do
    Hack.find_by(name: "Black IronHack").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_performance_report_to(project, project.student, "2nd Phase").deliver_now
    end
  end

  desc "send performance reports to students for 3rd phase"
  task send_email_to_students_3rd_phase: :environment do
    Hack.find_by(name: "Black IronHack").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_performance_report_to(project, project.student, "3rd Phase").deliver_now
    end
  end

  desc "send performance reports to students for final phase"
  task send_email_to_students_final_phase: :environment do
    Hack.find_by(name: "Black IronHack").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_performance_report_to(project, project.student, "Final Phase").deliver_now
    end
  end
end
