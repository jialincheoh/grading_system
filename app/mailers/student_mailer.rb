class StudentMailer < ApplicationMailer
  default from: 'purdueironhack@gmail.com'

  def send_performance_report_to(project, student, phase)
    @student = student
    @project = project
    @phase = phase
    @project_ids = Project.joins(:hack).where(hacks: { name: project.hack.name }).pluck(:id)
    mail(to: @student.email, subject: 'Ironhack Performance Report')
    EmailLog.create!(hack_id: @project.hack.id, project_id: @project.id, student_id: @student.id, student_email: @student.email, phase: @phase, sent_at: DateTime.now)
  end

  def send_reminder_to(student, phase)
    @student = student
    @phase = phase
    mail(to: @student.email, subject: 'Ironhack Submission Reminder')
  end

  def send_new_performance_report_to(project, student, phase)
    @project = project
    @student = student
    @phase = phase
    @project_ids = Project.joins(:hack).where(hacks: { name: project.hack.name }).pluck(:id)
    mail(to: @student.email, subject: 'Your app has been evaluated')
    EmailLog.create!(hack_id: @project.hack.id, project_id: @project.id, student_id: @student.id, student_email: @student.email, phase: @phase, sent_at: DateTime.now)
  end
end

