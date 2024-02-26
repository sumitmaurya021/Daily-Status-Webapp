class AdminMailer < ApplicationMailer
  def check_in_email(user)
    @user = user
    mail(to: 'mauryasumit222@gmail.com', subject: 'Employee Check-In Notification')
  end

  def check_out_email(user)
    @user = user
    mail(to: 'mauryasumit222@gmail.com', subject: 'Employee Check-Out Notification')
  end

end
