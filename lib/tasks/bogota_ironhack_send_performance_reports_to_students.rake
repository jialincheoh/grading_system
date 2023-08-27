namespace :bogota_ironhack_projects do
  desc "Bogota-Hack-0-2017 Hack: send performance reports to students for 1st phase"
  task bogota_0_send_email_to_students_1st_phase: :environment do
    Hack.find_by(name: "Bogota-Hack-0-2017").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_new_performance_report_to(project, project.student, "1st Phase").deliver_now
    end
  end

  desc "Bogota-Hack-0-2017 Hack: send performance reports to students for 2nd phase"
  task bogota_0_send_email_to_students_2nd_phase: :environment do
    Hack.find_by(name: "Bogota-Hack-0-2017").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_new_performance_report_to(project, project.student, "2nd Phase").deliver_now
    end
  end

  desc "Bogota-Hack-0-2017 Hack: send performance reports to students for 3rd phase"
  task bogota_0_send_email_to_students_3rd_phase: :environment do
    Hack.find_by(name: "Bogota-Hack-0-2017").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_new_performance_report_to(project, project.student, "3rd Phase").deliver_now
    end
  end

  desc "Bogota-Hack-0-2017 Hack: send performance reports to students for 4th phase"
  task bogota_0_send_email_to_students_4th_phase: :environment do
    Hack.find_by(name: "Bogota-Hack-0-2017").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_new_performance_report_to(project, project.student, "4th Phase").deliver_now
    end
  end

  desc "Bogota-Hack-0-2017 Hack: send performance reports to students for 5th phase"
  task bogota_0_send_email_to_students_5th_phase: :environment do
    Hack.find_by(name: "Bogota-Hack-0-2017").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_new_performance_report_to(project, project.student, "5th Phase").deliver_now
    end
  end

  desc "Bogota-Hack-1-2017 Hack: send performance reports to students for 1st phase"
  task bogota_1_send_email_to_students_1st_phase: :environment do
    Hack.find_by(name: "Bogota-Hack-1-2017").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_new_performance_report_to(project, project.student, "1st Phase").deliver_now
    end
  end

  desc "Bogota-Hack-1-2017 Hack: send performance reports to students for 2nd phase"
  task bogota_1_send_email_to_students_2nd_phase: :environment do
    Hack.find_by(name: "Bogota-Hack-1-2017").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_new_performance_report_to(project, project.student, "2nd Phase").deliver_now
    end
  end

  desc "Bogota-Hack-1-2017 Hack: send performance reports to students for 3rd phase"
  task bogota_1_send_email_to_students_3rd_phase: :environment do
    Hack.find_by(name: "Bogota-Hack-1-2017").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_new_performance_report_to(project, project.student, "3rd Phase").deliver_now
    end
  end

  desc "Bogota-Hack-1-2017 Hack: send performance reports to students for 4th phase"
  task bogota_1_send_email_to_students_4th_phase: :environment do
    Hack.find_by(name: "Bogota-Hack-1-2017").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_new_performance_report_to(project, project.student, "4th Phase").deliver_now
    end
  end

  desc "Bogota-Hack-1-2017 Hack: send performance reports to students for 5th phase"
  task bogota_1_send_email_to_students_5th_phase: :environment do
    Hack.find_by(name: "Bogota-Hack-1-2017").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_new_performance_report_to(project, project.student, "5th Phase").deliver_now
    end
  end

  desc "Bogota-Hack-2-2017 Hack: send performance reports to students for 1st phase"
  task bogota_2_send_email_to_students_1st_phase: :environment do
    Hack.find_by(name: "Bogota-Hack-2-2017").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_new_performance_report_to(project, project.student, "1st Phase").deliver_now
    end
  end

  desc "Bogota-Hack-2-2017 Hack: send performance reports to students for 2nd phase"
  task bogota_2_send_email_to_students_2nd_phase: :environment do
    Hack.find_by(name: "Bogota-Hack-2-2017").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_new_performance_report_to(project, project.student, "2nd Phase").deliver_now
    end
  end

  desc "Bogota-Hack-2-2017 Hack: send performance reports to students for 3rd phase"
  task bogota_2_send_email_to_students_3rd_phase: :environment do
    Hack.find_by(name: "Bogota-Hack-2-2017").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_new_performance_report_to(project, project.student, "3rd Phase").deliver_now
    end
  end

  desc "Bogota-Hack-2-2017 Hack: send performance reports to students for 4th phase"
  task bogota_2_send_email_to_students_4th_phase: :environment do
    Hack.find_by(name: "Bogota-Hack-2-2017").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_new_performance_report_to(project, project.student, "4th Phase").deliver_now
    end
  end

  desc "Bogota-Hack-2-2017 Hack: send performance reports to students for 5th phase"
  task bogota_2_send_email_to_students_5th_phase: :environment do
    Hack.find_by(name: "Bogota-Hack-2-2017").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_new_performance_report_to(project, project.student, "5th Phase").deliver_now
    end
  end

  desc "Bogota-Hack-3-2017 Hack: send performance reports to students for 1st phase"
  task bogota_3_send_email_to_students_1st_phase: :environment do
    Hack.find_by(name: "Bogota-Hack-3-2017").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_new_performance_report_to(project, project.student, "1st Phase").deliver_now
    end
  end

  desc "Bogota-Hack-3-2017 Hack: send performance reports to students for 2nd phase"
  task bogota_3_send_email_to_students_2nd_phase: :environment do
    Hack.find_by(name: "Bogota-Hack-3-2017").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_new_performance_report_to(project, project.student, "2nd Phase").deliver_now
    end
  end

  desc "Bogota-Hack-3-2017 Hack: send performance reports to students for 3rd phase"
  task bogota_3_send_email_to_students_3rd_phase: :environment do
    Hack.find_by(name: "Bogota-Hack-3-2017").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_new_performance_report_to(project, project.student, "3rd Phase").deliver_now
    end
  end

  desc "Bogota-Hack-3-2017 Hack: send performance reports to students for 4th phase"
  task bogota_3_send_email_to_students_4th_phase: :environment do
    Hack.find_by(name: "Bogota-Hack-3-2017").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_new_performance_report_to(project, project.student, "4th Phase").deliver_now
    end
  end

  desc "Bogota-Hack-3-2017 Hack: send performance reports to students for 5th phase"
  task bogota_3_send_email_to_students_5th_phase: :environment do
    Hack.find_by(name: "Bogota-Hack-3-2017").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_new_performance_report_to(project, project.student, "5th Phase").deliver_now
    end
  end
end
