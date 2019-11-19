class ImportMailer < ApplicationMailer
	default from: 'icewatch-admin@met.no'

  def daily_summary(email, cruises, users)
    @users = users
    @cruises = cruises

    mail(to: email, subject: 'IceWatch Daily Summary')
  end
end
