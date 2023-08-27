# Preview all emails at http://localhost:3000/rails/mailers/grader_mailer
class PerformanceReportMailerPreview < ActionMailer::Preview

  def send_email_to
    project = Project.last
    student = project.student
    phase = "1st Phase"
    PerformanceReportMailer.send_email_to(project, student, phase)
  end
end
