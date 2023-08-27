namespace :purdue_ironhack_projects do
  desc "Purdue-Hack-0-2017 Hack: send performance reports to students for 1st phase"
  task purdue_0_send_email_to_students_1st_phase: :environment do
    Hack.find_by(name: "Purdue-Hack-0-2017").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_new_performance_report_to(project, project.student, "1st Phase").deliver_now
    end
  end

  desc "Purdue-Hack-0-2017 Hack: send performance reports to students for 2nd phase"
  task purdue_0_send_email_to_students_2nd_phase: :environment do
    Hack.find_by(name: "Purdue-Hack-0-2017").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_new_performance_report_to(project, project.student, "2nd Phase").deliver_now
    end
  end

  desc "Purdue-Hack-0-2017 Hack: send performance reports to students for 3rd phase"
  task purdue_0_send_email_to_students_3rd_phase: :environment do
    Hack.find_by(name: "Purdue-Hack-0-2017").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_new_performance_report_to(project, project.student, "3rd Phase").deliver_now
    end
  end

  desc "Purdue-Hack-0-2017 Hack: send performance reports to students for Final phase"
  task purdue_0_send_email_to_students_final_phase: :environment do
    Hack.find_by(name: "Purdue-Hack-0-2017").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_new_performance_report_to(project, project.student, "Final Phase").deliver_now
    end
  end
end
