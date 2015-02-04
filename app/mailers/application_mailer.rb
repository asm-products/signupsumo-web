class ApplicationMailer < ActionMailer::Base
  # include Roadie::Rails::Automatic

  default from: 'notifications@signupsumo.com'

  layout 'mailer'

end
