class AdminMailer < ApplicationMailer
  def check_in_email(user)
    @user = user
    mail(to: 'mauryasumit222@gmail.com', subject: 'Employee Check-In Notification')
  end
  def check_out_email(user)
    @user = user
    mail(to: 'mauryasumit222@gmail.com', subject: 'Employee Check-Out Notification')
  end
  def new_status_email(user, status)
    @user = user
    @status = status
    mail(to: 'mauryasumit222@gmail.com', subject: 'Employee Created New Status Now')
  end
end
