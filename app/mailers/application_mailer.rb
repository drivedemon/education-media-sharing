class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@education.com <no-reply@education.com>"
  layout "mailer"
end
