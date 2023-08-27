namespace :hack_2 do
  desc "send reminder emails to students for 1st phase"
  task send_reminder_to_students_for_1st_phase: :environment do
    Hack.find_by(name: "Black IronHack").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_reminder_to(project.student, "1st Phase").deliver_now
    end
  end

  desc "send reminder emails to students for 2nd phase"
  task send_reminder_to_students_for_2nd_phase: :environment do
    Hack.find_by(name: "Black IronHack").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_reminder_to(project.student, "2nd Phase").deliver_now
    end
  end

  desc "send reminder emails to students for 3rd phase"
  task send_reminder_to_students_for_3rd_phase: :environment do
    Hack.find_by(name: "Black IronHack").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_reminder_to(project.student, "3rd Phase").deliver_now
    end
  end

  desc "send reminder emails to students for Final phase"
  task send_reminder_to_students_for_final_phase: :environment do
    Hack.find_by(name: "Black IronHack").projects.each do |project|
      puts "sending email to #{project.student.email}"
      StudentMailer.send_reminder_to(project.student, "Final Phase").deliver_now
    end
  end
end
