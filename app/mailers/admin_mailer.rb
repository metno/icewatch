## for mailing admins when notable tasks are prefored 
class AdminMailer < ApplicationMailer
  ## this emails all admins by default
  default to: Proc.new { User.where(role: 'admin').pluck(:email) }
  
  def new_user(user)
    ## email for when when a new account is created
    @user = user
    mail(subject: 'New User Registered')
  end

end
